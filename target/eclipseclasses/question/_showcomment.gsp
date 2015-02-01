
<div class="commentContentShow" class="property-value" aria-labelledby="content-label">
	<g:each in="${commentShow.comments}" var="comment">	
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
							
						<g:link controller="comment" class="edit  btn btn-primary" action="edit" resource="${comment}" params="[questionId: questionId]"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="delete btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</g:if>
					<g:link controller="comment" class="create  btn btn-warning" action="create" params="[post: comment.id, questionId: questionId]"><g:message code="default.new.comment" default="New Comment" /></g:link>
				</fieldset>
			</g:form>
			<g:if test="${comment.comments.size() != 0}">
				<g:render template="showcomment" model="['commentShow': comment, 'questionId': questionId]"/>	
			</g:if>
		</div>
	</g:each>
</div>
