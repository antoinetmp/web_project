
<%@ page import="fr.isima.stackoverflow.Badge" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'badge.label', default: 'Badge')}" />
		<title><g:message code="badge.list.label" default="Badge list" /></title>
	</head>
	<body>
		<div id="list-badge" class="content scaffold-list" role="main">
			<h1><g:message code="badge.list.label" default="Badge list" /></h1>
			<g:if test="${userService.getCurrentUser()?.isAdmin()}">
				<g:link class="create btn btn-primary" action="create">
					<i class="glyphicon glyphicon-plus"></i>
					<g:message code="badge.new.label" args="New Badge" />
				</g:link>
			</g:if>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table">
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'badge.name.label', default: 'Name')}" />
					
						<th><g:message code="badge.category.label" default="Category" /></th>
					
						<g:sortableColumn property="urlImage" title="${message(code: 'badge.urlImage.label', default: 'Url Image')}" />
					
						<g:sortableColumn property="min" title="${message(code: 'badge.min.label', default: 'Min')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${badgeInstanceList}" status="i" var="badgeInstance">
					<tr class="${(i % 2) == 0 ? 'active' : ''}">
					
						<td>${fieldValue(bean: badgeInstance, field: "name")}</td>
					
						<td>${fieldValue(bean: badgeInstance, field: "category")}</td>
					
						<td>${fieldValue(bean: badgeInstance, field: "urlImage")}</td>
					
						<td>${fieldValue(bean: badgeInstance, field: "min")}</td>
						
						<g:if test="${userService.getCurrentUser()?.isAdmin()}">
							<td class="actionAdmin">
								
								<g:form url="[resource:badgeInstance, action:'delete']" method="DELETE">
									<fieldset class="buttons">
										<g:link class="text-right create btn btn-primary" action="edit" resource="${badgeInstance}" >
											<i class="glyphicon glyphicon-pencil"></i>
										</g:link>
										<g:actionSubmit class="delete btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
									</fieldset>
								</g:form>	
							</td>
						</g:if>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${badgeInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
