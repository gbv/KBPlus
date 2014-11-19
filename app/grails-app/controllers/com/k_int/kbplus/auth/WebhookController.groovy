package com.k_int.kbplus.auth

import org.springframework.dao.DataIntegrityViolationException

class WebhookController {

	def springSecurityService
	def webhookService

	def api(){
		switch(request.method){
			case "POST":
				def json = request.JSON
				save()
				break
			case "GET":
				def json = request.JSON
				if(params.id>0 && params.id){
			        show()
				}else{
					response.status = 400 //Bad Request
					render "SHOW request must include the id"
				}
				break
			case "PUT":
				def json = request.JSON
				update()
				break
			case "DELETE":
				def json = request.JSON
				if(params.id){
					def hook = Webhook.get(params.id)
					if(hook){
					  hook.delete()
					  response.status = 200
					  render "Successfully Deleted."
					}else{
					  response.status = 404 //Not Found
					  render "Id not found."
					}
				}else{
					response.status = 400 //Bad Request
					render "DELETE request must include the id"
				}
				break
		  }
	}

	static defaultAction = 'list'


	def list() {
		def user = loggedInUser()
		if(!user){
			redirect(uri: "/")
			return
		}

		def webhookList = isSuperuser() ? Webhook.list(params) : Webhook.findAllByUser(user, [max:params.max, sort:params.sort, order:params.order, offset:params.offset] )
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[webhookInstanceList: webhookList, webhookInstanceTotal: webhookList.size(),params:params]
	}

	def create() {
		if(!springSecurityService.isLoggedIn()){
			redirect(uri: "/")
			return
		}
		def formats = ['JSON','XML']
		[webhookInstance: new Webhook(params),service:grailsApplication.config.webhook.services,format:formats]
	}

	def save() {
		def user = loggedInUser()
		if(!user){
			redirect(uri: "/")
			return
		}
		def formats = ['JSON','XML']
		Webhook webhookInstance = Webhook.findByUrlAndService(params.url,params.service)
		if(webhookInstance){
			flash.message = "URL EXISTS: PLEASE CHECK YOUR REGISTERED WEBHOOKS TO MAKE SURE THIS IS NOT A DUPLICATE."
			render(view:"create",model:[params:params])
			return
		}

		if(!webhookService.validateUrl(params.url)){
			flash.message = "BAD PROTOCOL: URL MUST BE FULLY QUALIFIED DOMAIN NAME (OR IP ADDRESS) FORMATTED WITH HTTP/HTTPS. PLEASE TRY AGAIN."
			render(view:"create",model:[params:params,service:grailsApplication.config.webhook.services,format:formats])
			return
		}

		webhookInstance = new Webhook(params)
		webhookInstance.user=user

		if (webhookInstance.save(flush: true)) {
			flash.message = message(code: 'default.created.message', args: [message(code: 'webhook.label', default: 'Webhook'), webhookInstance.id])
			redirect(action:"show", id: webhookInstance.id)
			return
		}

		flash.message = "INVALID/MALFORMED DATA: PLEASE SEE DOCS FOR 'JSON' FORMED STRING AND PLEASE TRY AGAIN."
		render(view:"create",model:[params:params,service:grailsApplication.config.webhook.services,format:formats])
	}

	def edit() {
		if(!springSecurityService.isLoggedIn()){
			redirect(uri: "/")
			return
		}
		def formats = ['JSON','XML']
		[webhookInstance: Webhook.get(params.id),service:grailsApplication.config.webhook.services,format:formats]
	}

	def update() {
		def user = loggedInUser()
		if(!user){
			redirect(uri: "/")
			return
		}

		Webhook webhookInstance = Webhook.findByIdAndUser(params.id, user)
		if(!webhookInstance){
			flash.message = "WEBHOOK NOT FOUND: NO WEBHOOK WITH THAT ID FOUND BELONGING TO CURRENT USER."
			render(view:"create",model:[params:params])
			return
		}

		webhookInstance.name = params.name
		webhookInstance.url = params.url
		webhookInstance.format = params.format
		webhookInstance.service = params.service

		if (webhookInstance.save(flush: true)) {
			flash.message = message(code: 'default.updated.message', args: [message(code: 'webhook.label', default: 'Webhook'), webhookInstance.id])
			redirect(action:"show", id: webhookInstance.id)
			return
		}

		flash.message = "INVALID/MALFORMED DATA: PLEASE SEE DOCS FOR 'JSON' FORMED STRING AND PLEASE TRY AGAIN."
		render(view:"create",model:[params:params])
	}

	def show() {
		def user = loggedInUser()
		if(!user){
			redirect(uri: "/")
			return
		}

		def webhookInstance = isSuperuser() ? Webhook.get(params.id) : Webhook.findByUserAndId(user,params.id.toLong())

		if (webhookInstance) {
			render(view:"show",model:[webhookInstance: webhookInstance])
			return
		}

		flash.message = message(code: 'default.not.found.message', args: [message(code: 'webhook.label', default: 'Webhook'), params.id])
		redirect(action: "list")
	}

	def delete() {
		def user = loggedInUser()
		if(!user){
			redirect(uri: "/")
			return
		}

		def webhookInstance = isSuperuser() ? Webhook.get(params.id) : Webhook.findByUserAndId(user,params.id.toLong())

		if (!webhookInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'webhook.label', default: 'Webhook'), params.id])
			redirect(action: "list")
			return
		}

		try {
			webhookInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'webhook.label', default: 'Webhook'), params.id])
			redirect(action: "list")
		}catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'webhook.label', default: 'Webhook'), params.id])
			redirect(action: "show", id: params.id)
		}
	}

	def reset() {
		def user = loggedInUser()
		if(!user){
			redirect(uri: "/")
			return
		}

		Webhook webhookInstance = Webhook.findByIdAndUser(params.id, user)
		if(!webhookInstance){
			flash.message = "WEBHOOK NOT FOUND: NO WEBHOOK WITH THAT ID FOUND BELONGING TO CURRENT USER."
			render(view:"list",model:[params:params])
			return
		}

		webhookInstance.attempts = 0

		if (webhookInstance.save(flush: true)) {
			flash.message = message(code: 'default.reset.message', args: [message(code: 'webhook.label', default: 'Webhook'), webhookInstance.id])
			redirect(action:"list")
			return
		}
	}

	protected loggedInUser() {
		springSecurityService.isLoggedIn() ? User.load(springSecurityService.principal.id) : null
	}

	protected boolean isSuperuser() {
		springSecurityService.principal.authorities*.authority.any { grailsApplication.config.webhook.authorities.contains(it) }
	}
}
