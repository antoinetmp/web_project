
<%@ page import="fr.isima.stackoverflow.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="user.list.label" default="User list" /></title>
	</head>
	<body>
		
		<div id="list-user" class="content scaffold-list" role="main">
			<h1><g:message code="user.list.label" default="User list" /></h1>
			<g:if test="${userService.getCurrentUser()?.isAdmin()}">
				<div>
					<g:link class="create btn btn-primary" action="create">
						<i class="glyphicon glyphicon-plus"></i>
						<g:message code="user.new.label" default="New user" />
					</g:link>
				</div>	
			</g:if>
			
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table">
			<thead>
					<tr>
					
						<g:sortableColumn property="username" title="${message(code: 'user.username.label', default: 'Username')}" />
					
						<g:sortableColumn property="firstname" title="${message(code: 'user.firstname.label', default: 'Firstname')}" />
					
						<g:sortableColumn property="lastname" title="${message(code: 'user.lastname.label', default: 'Lastname')}" />
					
						<g:sortableColumn property="reputation" title="${message(code: 'user.reputation.label', default: 'Reputation')}" />
											
					</tr>
				</thead>
				<tbody>
				<g:each in="${userInstanceList}" status="i" var="userInstance">
					<tr class="${(i % 2) == 0 ? 'active' : ''}">
					
						<td><g:link action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: "username")}</g:link></td>
					
						<td>${fieldValue(bean: userInstance, field: "firstname")}</td>
						
						<td>${fieldValue(bean: userInstance, field: "lastname")}</td>
						
						<td>${fieldValue(bean: userInstance, field: "reputation")}</td>
						
						<g:if test="${userService.getCurrentUser()?.isAdmin()}">
							<td class="actionAdmin">
								<fieldset class="buttons">
									<g:link class="text-right create btn btn-primary" action="edit" resource="${userInstance}" >
										<i class="glyphicon glyphicon-pencil"></i>
									</g:link>
									<g:if test="${!userInstance.isAdmin()}">
										<g:if test="${userInstance.isModo()}">
											<g:link class="text-right create btn btn-danger" action="removeModo" resource="${userInstance}" >
												<i class="glyphicon glyphicon-remove-circle"></i>
												<g:message code="user.remove.modo.label" default="Remove modo" />
											</g:link>
										</g:if>
										<g:else>
											<g:link class="text-right create btn btn-warning" action="makeModo" resource="${userInstance}" >
												<i class="glyphicon glyphicon-ok-circle"></i>
												<g:message code="user.make.modo.label" default="Make modo" />
											</g:link>
										</g:else>
									</g:if>
								</fieldset>
							</td>
						</g:if>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${userInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
