<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'webhook.label', default: 'Webhook')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#edit-webhook" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="edit-webhook" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${webhookInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${webhookInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form method="post" >
				<g:hiddenField name="id" value="${webhookInstance?.id}" />
				<g:hiddenField name="version" value="${webhookInstance?.version}" />
				<fieldset class="form">

					<div class="fieldcontain ${hasErrors(bean: webhookInstance, field: 'name', 'error')} ">
						<label for="name">
							<g:message code="webhook.name.label" default="Name" />
						</label>
						<g:textField name="name" value="${webhookInstance?.name}"/>
					</div>

					<div class="fieldcontain ${hasErrors(bean: webhookInstance, field: 'url', 'error')} ">
						<label for="url">
							<g:message code="webhook.url.label" default="Url" />
						</label>
						<g:textField name="url" value="${webhookInstance?.url}"/>
					</div>

					<div class="fieldcontain ${hasErrors(bean: webhookInstance, field: 'format', 'error')} ">
						<label for="format">
							<g:message code="webhook.format.label" default="Format" />
						</label>
						<span class="styled-select"><g:select name="format" from="${format}" value="${webhookInstance?.format}"/></span>
					</div>

					<div class="fieldcontain ${hasErrors(bean: webhookInstance, field: 'service', 'error')} ">
						<label for="service">
							<g:message code="webhook.service.label" default="Service" />
						</label>
						<span class="styled-select"><g:select name="service" from="${service}" value="${webhookInstance?.service}"/></span>
					</div>

				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
