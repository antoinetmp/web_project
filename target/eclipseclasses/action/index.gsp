
<%@ page import="fr.isima.stackoverflow.Action" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'action.label', default: 'Action')}" />
		<title><g:message code="action.list.label" default="Action list" /></title>
	</head>
	<body>	
		<div id="list-action" class="content scaffold-list" role="main">
			<h1><<g:message code="action.list.label" default="Action list" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table">
			<thead>
					<tr>
					
						<g:sortableColumn property="date" title="${message(code: 'action.date.label', default: 'Date')}" />
					
						<th><g:message code="action.label" default="Action" /></th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${actionInstanceList}" status="i" var="actionInstance">
					<tr class="${(i % 2) == 0 ? 'active' : ''}">
					
						<td>${fieldValue(bean: actionInstance, field: "date")}</td>
						<td>
							<g:if test="${fieldValue(bean: actionInstance, field: "type") == "CREATE_QUESTION"}">
								<g:message code="action.question.creation" default="Creation" args="[actionInstance.post.title]"/>
							</g:if>
							<g:elseif test="${fieldValue(bean: actionInstance, field: "type") == "EDIT_QUESTION"}">
								<g:message code="action.question.edit" default="Edit" args="[actionInstance.post.title]"/>
							</g:elseif>
							<g:elseif test="${fieldValue(bean: actionInstance, field: "type") == "CREATE_ANSWER"}">
								<g:message code="action.question.creation" default="Creation" args="[actionInstance.post.question.title]"/>
							</g:elseif>
							<g:elseif test="${fieldValue(bean: actionInstance, field: "type") == "EDIT_ANSWER"}">
								<g:message code="action.question.edit" default="Edit" args="[actionInstance.post.question.title]"/>
							</g:elseif>
							<g:elseif test="${fieldValue(bean: actionInstance, field: "type") == "CREATE_COMMENT"}">
								<g:message code="action.comment.creation" default="Creation"/>
							</g:elseif>
							<g:elseif test="${fieldValue(bean: actionInstance, field: "type") == "EDIT_COMMENT"}">
								<g:message code="action.comment.edit" default="Edit"/>
							</g:elseif>
							<g:elseif test="${fieldValue(bean: actionInstance, field: "type") == "UP_VOTE_QUESTION"}">
								<g:message code="action.question.vote" default="Vote" args="[actionInstance.post.title]"/>
							</g:elseif>
							<g:elseif test="${fieldValue(bean: actionInstance, field: "type") == "DOWN_VOTE_QUESTION"}">
								<g:message code="action.question.vote" default="Vote" args="[actionInstance.post.title]"/>
							</g:elseif>
							<g:elseif test="${fieldValue(bean: actionInstance, field: "type") == "UP_VOTE_ANSWER"}">
								<g:message code="action.answer.vote" default="Vote" args="[actionInstance.post.question.title]"/>
							</g:elseif>
							<g:elseif test="${fieldValue(bean: actionInstance, field: "type") == "DOWN_VOTE_ANSWER"}">
								<g:message code="action.answer.vote" default="Vote" args="[actionInstance.post.question.title]"/>
							</g:elseif>
						</td>
									
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${actionInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
