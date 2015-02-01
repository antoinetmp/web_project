<%@ page import="fr.isima.stackoverflow.Badge" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'badge.label', default: 'Badge')}" />
		<title><g:message code="badge.edit.label" default="Edit badge" /></title>
	</head>
	<body>
		<g:link class="list" action="index"><g:message code="badge.list.label" default="Badge list" /></g:link>
		<div id="edit-badge" class="content scaffold-edit" role="main">
			<h1><g:message code="badge.edit.label" default="Edit badge" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${badgeInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${badgeInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:badgeInstance, action:'update']" method="PUT" class="form-horizontal">
				<g:hiddenField name="version" value="${badgeInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
