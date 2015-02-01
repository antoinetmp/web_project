<%@ page import="fr.isima.stackoverflow.Comment" %>

<div class="form-group fieldcontain ${hasErrors(bean: commentInstance, field: 'content', 'error')} required">
	<label for="content" class="col-sm-2 control-label">
		<g:message code="comment.content.label" default="Content" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
		<g:textArea id="commentContentForm" name="content" class="form-control" maxlength="4000" required="" value="${commentInstance?.content}" rows="10" cols="75"/>
	</div>
</div>



