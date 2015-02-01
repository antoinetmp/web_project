
<%@ page import="fr.isima.stackoverflow.Question" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
		<title><g:message code="question.list.label" default="Question list" /></title>
	</head>
	<body>
		<div id="list-question" class="content scaffold-list" role="main">
			<h1><g:message code="question.list.label" default="Question list" /></h1>
			
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<div>
				<g:link class="create btn btn-primary" action="create">
					<i class="glyphicon glyphicon-plus"></i>
					<g:message code="question.new.label" default="New question" />
				</g:link>
				
			</div>
			<br/>	
			<table class="table">
			<thead>
					<tr>
						<g:sortableColumn property="mark" title="${message(code: 'question.mark.label', default: 'Mark')}" />
				
						<th><g:message code="question.answers.label" default="Answers" /></th>
				
						<g:sortableColumn property="title" title="${message(code: 'question.title.label', default: 'Title')}" />
					
						<g:sortableColumn property="creationDate" title="${message(code: 'question.creationDate.label', default: 'Creation Date')}" />
					
						<g:sortableColumn property="updateDate" title="${message(code: 'question.updateDate.label', default: 'Update Date')}" />
					</tr>
				</thead>
				<tbody>
				<g:each in="${questionInstanceList}" status="i" var="questionInstance">
					<tr class="${(i % 2) == 0 ? 'active' : ''}">
						
							<td>
								${fieldValue(bean: questionInstance, field: "mark")}
							</td>
							
							<td>
								<g:link action="show" id="${questionInstance.id}">
									${questionInstance.answers.size()}
								</g:link>
							</td>
						
							<td>
								<g:link action="show" id="${questionInstance.id}">
									${fieldValue(bean: questionInstance, field: "title")}
								</g:link>
								<br />
								<g:each in="${questionInstance.categories}" status="j" var="questionInstanceCategory">
									<span class="label label-primary">${questionInstanceCategory.label}</span>
								</g:each>
								
							</td>
													
							<td><g:formatDate date="${questionInstance.creationDate}" /></td>
						
							<td><g:formatDate date="${questionInstance.updateDate}" /></td>
							
							<g:if test="${userService.getCurrentUser()?.isAdmin()}">
							<td class="actionAdmin">
								
								<g:form url="[resource:questionInstance, action:'delete']" method="DELETE">
									<fieldset class="buttons">
										<g:link class="text-right create btn btn-primary" action="edit" resource="${questionInstance}" >
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
				<g:paginate class="paginationUl" total="${questionInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
