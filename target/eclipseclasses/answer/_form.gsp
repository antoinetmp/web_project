<%@ page import="fr.isima.stackoverflow.Answer" %>


<div class="form-group fieldcontain ${hasErrors(bean: answerInstance, field: 'content', 'error')} required">
	<label for="content" class="col-sm-2 control-label">
		<g:message code="answer.content.label" default="Content" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
		<g:textArea id="answerContentForm" class="form-control" maxlength="4000" name="content" required="" value="${answerInstance?.content}" rows="10" cols="75"/>
	</div>
</div>



