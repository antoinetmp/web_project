
<%@page import="fr.isima.stackoverflow.UserService"%>
<%@ page import="fr.isima.stackoverflow.Question" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
		<title><g:message code="question.show.label" default="Show question" /></title>
	</head>
	<body>
		<div id="show-question" class="content scaffold-show" role="main">

			<h1 id="questionTitleShow"><g:fieldValue bean="${questionInstance}" field="title"/></h1>				
			<div id="datesQuestion" ><g:message code="question.creationDate.label" default="Creation Date" />
			<g:formatDate date="${questionInstance?.creationDate}" />
	
			<g:message code="question.updateDate.label" default="Update Date" />
			<g:formatDate date="${questionInstance?.updateDate}" /></div>
			
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

					
			<div class="mark" >
				<g:form url="[resource:questionInstance]" method="POST">
					<g:actionSubmit class="buttonMark plusVote btn btn-info" action="plusVote" value="+" />
					<br />
					<g:fieldValue bean="${questionInstance}" field="mark"/>
					<br />
					<g:actionSubmit class="buttonMark minusVote btn btn-info" action="minusVote" value="-" />
				</g:form>
			</div>
			<div class="contentQuestion">
				<div id="questionContentShow" class="property-value" aria-labelledby="content-label">
					<g:fieldValue bean="${questionInstance}" field="content"/> <br />
				</div>
				
				<div id="questionCategoriesShow" class="property-value" aria-labelledby="content-label">
					<g:each in="${questionInstance.categories}" status="j" var="questionInstanceCategory">
						<span class="label label-primary">${questionInstanceCategory.label}</span>
					</g:each>
				</div>
				
				<div class="questionCreatedByShow" class="property-value" aria-labelledby="content-label">
					<g:message code="default.created.by" />
					${userService.getCreationUser(questionInstance).username}
				</div>
			</div>
			
					
			<g:form class="questionButtonShow" url="[resource:questionInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:if test="${sec.loggedInUserInfo(field:"id").equals(userService.getCreationUser(questionInstance).id.toString())
									|| userService.getCurrentUser()?.isAdminOrModo()}">
			
						<g:link class="edit btn btn-primary" action="edit" resource="${questionInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="delete btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</g:if>
					<g:link controller="answer" class="create btn btn-success" action="create" params="[questionId: questionInstance.id]"><g:message code="default.new.answer" default="New Test" /></g:link>
					<g:link controller="comment" class="create btn btn-warning" action="create" params="[post: questionInstance.id, questionId: questionInstance.id]"><g:message code="default.new.comment" default="New Comment" /></g:link>
				</fieldset>
			</g:form>
			<div class="commentContentShow" class="property-value" aria-labelledby="content-label">
				<g:each in="${questionInstance.comments}" var="comment">	
					<div class="commentShow">
						<g:fieldValue bean="${comment}" field="content"/>
						<div class="questionCreatedByShow" class="property-value" aria-labelledby="content-label">
							<g:message code="default.created.by" />
							${userService.getCreationUser(comment).username}
						</div>
						<g:form class="questionButtonShow" controller="comment" url="[resource:comment, action:'delete']" method="DELETE">
							<fieldset class="buttons">
								<g:hiddenField name="questionId" value="${questionInstance.id }"/>
								<g:if test="${sec.loggedInUserInfo(field:"id").equals(userService.getCreationUser(questionInstance).id.toString())
										|| userService.getCurrentUser()?.isAdminOrModo()}">
									<g:link controller="comment" class="edit btn btn-primary" action="edit" resource="${comment}" params="[questionId: questionInstance.id]"><g:message code="default.button.edit.label" default="Edit" /></g:link>
									<g:actionSubmit class="delete btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
								</g:if>
								<g:link controller="comment" class="create btn btn-warning" action="create" params="[post: comment.id, questionId: questionInstance.id]"><g:message code="default.new.comment" default="New Comment" /></g:link>
							</fieldset>
						</g:form>											
						<g:render template="showcomment" model="['commentShow': comment, 'questionId': questionInstance.id]"/>
					</div>
				</g:each>
			</div>
			<g:if test="${questionInstance.answers.size() != 0}">
				<h1 id="answersTitleShow">
					${questionInstance.answers.size()}
					<g:if test="${questionInstance.answers.size() == 1}">
						<g:message code="question.answer.label" default="Answer" />				
					</g:if>
					<g:else>
						<g:message code="question.answers.label" default="Answers" />			
					</g:else>
				</h1>	
				<g:each in="${questionInstance.answers.sort {-it.mark }}" var="answer">
					<div class="answerShow">
						<div id="datesQuestion" >
							<g:message code="question.creationDate.label" default="Creation Date" />
							<g:formatDate date="${answer?.creationDate}" />
							<g:message code="question.updateDate.label" default="Update Date" />
							<g:formatDate date="${answer?.updateDate}" />
						</div>
					
						<div class="mark" >
							<g:form controller="answer" url="[resource:answer]" method="POST">
								<g:hiddenField name="questionId" value="${questionInstance.id }"/>
								<g:actionSubmit class="buttonMark plusVote btn btn-info" action="plusVote" value="${message(code: 'default.button.plus', default: '+')}" />
								<br />
								<g:fieldValue bean="${answer}" field="mark"/>
								<br />
								<g:actionSubmit class="buttonMark minusVote btn btn-info" action="minusVote" value="${message(code: 'default.button.minus', default: '-')}" />
							</g:form>
						</div>	
						<div class="contentAnswer">
							<div class="answerContentShow" class="property-value" aria-labelledby="content-label">
								<g:fieldValue bean="${answer}" field="content"/>
							</div>
							<div class="questionCreatedByShow" class="property-value" aria-labelledby="content-label">
								<g:message code="default.created.by" />
								${userService.getCreationUser(answer).username}
							</div>
						</div>
						<g:form class="questionButtonShow" controller="answer" url="[resource:answer, action:'delete']" method="DELETE">
							<fieldset class="buttons">
								<g:hiddenField name="questionId" value="${questionInstance.id }"/>
								<g:if test="${sec.loggedInUserInfo(field:"id").equals(userService.getCreationUser(questionInstance).id.toString())
										|| userService.getCurrentUser()?.isAdminOrModo()}">
									<g:link controller="answer" class="edit btn btn-primary" action="edit" resource="${answer}" params="[questionId: questionInstance.id]"><g:message code="default.button.edit.label" default="Edit" /></g:link>
									<g:actionSubmit class="delete btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
								</g:if>
								<g:link controller="comment" class="create btn btn-warning" action="create" params="[post: answer.id, questionId: questionInstance.id]"><g:message code="default.new.comment" default="New Comment" /></g:link>
							</fieldset>
						</g:form>
	
						<div class="commentContentShow" class="property-value" aria-labelledby="content-label">
							<g:each in="${answer.comments}" var="comment">
								<div class="commentShow">
									<g:fieldValue bean="${comment}" field="content"/>
									<div class="questionCreatedByShow" class="property-value" aria-labelledby="content-label">
										<g:message code="default.created.by" />
										${userService.getCreationUser(comment).username}
									</div>
									<g:form class="questionButtonShow" controller="comment" url="[resource:comment, action:'delete', idQuestion:'${questionInstance.id}']" method="DELETE">
										<fieldset class="buttons">
											<g:hiddenField name="questionId" value="${questionInstance.id }"/>
											<g:if test="${sec.loggedInUserInfo(field:"id").equals(userService.getCreationUser(questionInstance).id.toString())
											|| userService.getCurrentUser()?.isAdminOrModo()}">
												<g:link controller="comment" class="edit btn btn-primary" action="edit" resource="${comment}" params="[questionId: questionInstance.id]"><g:message code="default.button.edit.label" default="Edit" /></g:link>
												<g:actionSubmit class="delete btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
											</g:if>
											<g:link controller="comment" class="create btn btn-warning" action="create" params="[post: comment.id, questionId: questionInstance.id]"><g:message code="default.new.comment" default="New Comment" /></g:link>
										</fieldset>
									</g:form>										
									<g:render template="showcomment" model="['commentShow': comment, 'questionId': questionInstance.id]"/>
								</div>
							</g:each>
						</div>
					</div>
				</g:each>
				
	
			</g:if>
		</div>
	</body>
</html>
