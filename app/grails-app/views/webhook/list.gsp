<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'webhook.label', default: 'Webhook')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-webhook" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-webhook" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
						<g:sortableColumn property="id" title="${message(code: 'webhook.id.label', default: 'Id')}"/>
						<g:sortableColumn property="user" title="${message(code: 'webhook.user.label', default: 'User')}" titleKey="webhookInstance.user.username"/>
						<g:sortableColumn property="name" title="${message(code: 'webhook.name.label', default: 'Name')}" />
						<g:sortableColumn property="url" title="${message(code: 'webhook.url.label', default: 'Url')}" />
						<g:sortableColumn property="format" title="${message(code: 'webhook.format.label', default: 'Format')}" />
						<g:sortableColumn property="service" title="${message(code: 'webhook.service.label', default: 'Service')}" />
						<g:sortableColumn property="attempts" title="${message(code: 'webhook.attempts.label', default: 'Attempts')}" />
						<th>&nbsp;</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${webhookInstanceList}" status="i" var="webhookInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td><g:link action="show" id="${webhookInstance.id}">${fieldValue(bean: webhookInstance, field: "id")}</g:link></td>
						<td>${webhookInstance.user.username}</td>
						<td>${fieldValue(bean: webhookInstance, field: "name")}</td>
						<td>${fieldValue(bean: webhookInstance, field: "url")}</td>
						<td>${fieldValue(bean: webhookInstance, field: "format")}</td>
						<td>${fieldValue(bean: webhookInstance, field: "service")}</td>
						<td>${fieldValue(bean: webhookInstance, field: "attempts")}</td>
						<td>
							<g:if test="${webhookInstance.attempts>=5}">
							<g:form action="reset" id="${webhookInstance.id}">
							<span class="button"><g:actionSubmit class='save' value='reset' action="reset"/></span>
							</g:form>
							</g:if>
						</td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${webhookInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
