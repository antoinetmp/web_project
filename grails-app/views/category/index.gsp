
<%@ page import="fr.isima.stackoverflow.Category" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'category.label', default: 'Category')}" />
		<title><g:message code="category.list.label" default="Category list" /></title>
	</head>
	<body>
		
		<div id="list-category" class="content scaffold-list" role="main">
			<h1><g:message code="category.list.label" default="Category list" /></h1>
			
			<g:if test="${userService.getCurrentUser()?.isAdmin()}">
				<g:link class="create btn btn-primary" action="create">
					<i class="glyphicon glyphicon-plus"></i>
					<g:message code="category.new.label" default="New category" />
				</g:link>
			</g:if>
			
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table tableCategory">
			<thead>
					<tr>
					
						<g:sortableColumn property="label" title="${message(code: 'category.label.label', default: 'Label')}" />
						
						
					</tr>
				</thead>
				<tbody>
				<g:each in="${categoryInstanceList}" status="i" var="categoryInstance">
					<tr class="${(i % 2) == 0 ? 'active' : ''}">
					
						<td>${fieldValue(bean: categoryInstance, field: "label")}</td>
						<g:if test="${userService.getCurrentUser()?.isAdmin()}">
							<td class="actionAdmin">
								
								<g:form url="[resource:categoryInstance, action:'delete']" method="DELETE">
									<fieldset class="buttons">
										<g:link class="text-right create btn btn-primary" action="edit" resource="${categoryInstance}" >
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
				<g:paginate total="${categoryInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
