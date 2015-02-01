
<%@ page import="fr.isima.stackoverflow.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="user.show.label" default="Show user" /></title>
	</head>
	<body>
		<div id="show-user" class="content scaffold-show" role="main">
			<h1><g:message code="user.show.label" default="Show user" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<dl class="property-list user dl-horizontal">
			
				<g:if test="${userInstance?.username}">
				<dt class="fieldcontain">
					<span id="username-label" class="property-label"><g:message code="user.username.label" default="Username" /></span>
				</dt>
				<dd>
					<span class="property-value" aria-labelledby="username-label"><g:fieldValue bean="${userInstance}" field="username"/></span>
					
				</dd>
				</g:if>
				
				<g:if test="${userInstance?.firstname}">
				<dt class="fieldcontain">
					<span id="firstname-label" class="property-label"><g:message code="user.firstname.label" default="Firstname" /></span>
				</dt>
				<dd>
						<span class="property-value" aria-labelledby="firstname-label"><g:fieldValue bean="${userInstance}" field="firstname"/></span>
					
				</dd>
				</g:if>
			
				<g:if test="${userInstance?.lastname}">
				<dt class="fieldcontain">
					<span id="lastname-label" class="property-label"><g:message code="user.lastname.label" default="Lastname" /></span>
				</dt>
				<dd>
						<span class="property-value" aria-labelledby="lastname-label"><g:fieldValue bean="${userInstance}" field="lastname"/></span>
					
				</dd>
				</g:if>
		
				
	
			
				<g:if test="${userInstance?.actions}">
				<dt class="fieldcontain">
					<span id="actions-label" class="property-label"><g:message code="user.actions.label" default="Actions" /></span>
				</dt>
				<dd>
						<span class="property-value" aria-labelledby="actions-label">
							<g:link controller="action" action="index" params="[userId: userInstance.id]">
								<g:message code="user.list.actions" default="List actions" />					
							</g:link>
						</span>
				</dd>
				</g:if>
			
				<g:if test="${userInstance?.badges}">
				<dt class="fieldcontain">
					<span id="badges-label" class="property-label"><g:message code="user.badges.label" default="Badges" /></span>
				</dt>
				<dd>
						<g:each in="${userInstance.badges}" var="b">
						<span class="property-value" aria-labelledby="badges-label"><g:link controller="badge" action="show" id="${b.id}">${b.name}</g:link></span>
						</g:each>
					
				</dd>
				</g:if>
			
			
				<dt class="fieldcontain">
					<span id="reputation-label" class="property-label"><g:message code="user.reputation.label" default="Reputation" /></span>
				</dt>
				<dd>
						<span class="property-value" aria-labelledby="reputation-label"><g:fieldValue bean="${userInstance}" field="reputation"/></span>
					
				</dd>
				
				<dt class="fieldcontain">
					<span id="nbQuestions-label" class="property-label"><g:message code="user.nb.questions.label" default="Number of questions" /></span>
				</dt>
				<dd>
					<span class="property-value" aria-labelledby="nbQuestions-label">${userService.getNbQuestions(userInstance)}</span>
				</dd>
				<dt class="fieldcontain">
					<span id="nbAnswers-label" class="property-label"><g:message code="user.nb.answers.label" default="Number of answers" /></span>
				</dt>
				<dd>
					<span class="property-value" aria-labelledby="nbAnswers-label">${userService.getNbAnswers(userInstance)}</span>
				</dd>
				<dt class="fieldcontain">
					<span id="nbComments-label" class="property-label"><g:message code="user.nb.comments.label" default="Number of comments" /></span>
				</dt>
				<dd>
					<span class="property-value" aria-labelledby="nbComments-label">${userService.getNbComments(userInstance)}</span>
				</dd>
			</dl>
			<g:if test="${sec.loggedInUserInfo(field:"id").equals(userInstance.id.toString())
						|| userService.getCurrentUser()?.isAdmin()}">
				<g:form url="[resource:userInstance, action:'delete']" method="DELETE">
					<fieldset class="buttons">
						<g:link class="edit btn btn-primary" action="edit" resource="${userInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					</fieldset>
				</g:form>
			</g:if>
			
			
		</div>
	</body>
</html>
