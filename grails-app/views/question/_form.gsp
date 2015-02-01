<%@ page import="fr.isima.stackoverflow.Question" %>


<div class="form-group fieldcontain ${hasErrors(bean: questionInstance, field: 'title', 'error')} required">
	<label for="title" class="col-sm-2 control-label">
		<g:message code="question.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
      <g:textField name="title" class="form-control" required="" aria-describedby="basic-addon1" value="${questionInstance?.title}"/>
    </div>
</div>


<div class="form-group fieldcontain ${hasErrors(bean: questionInstance, field: 'categories', 'error')} ">
	<label for="categories" class="col-sm-2 control-label">
		<g:message code="question.categories.label" default="Categories" />
	</label>
	<div class="col-sm-10">
		<g:select name="categories" class="form-control" from="${fr.isima.stackoverflow.Category.list()}" multiple="multiple" optionKey="id" size="5" value="${questionInstance?.categories*.id}"/>
	</div>
	
</div>

<div class="form-group fieldcontain ${hasErrors(bean: questionInstance, field: 'content', 'error')} required">
	<label for="content" class="col-sm-2 control-label">
		<g:message code="question.content.label" default="Content" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
		<g:textArea id="questionContentForm" class="form-control" maxlength="4000" name="content" required="" value="${questionInstance?.content}" rows="10" cols="75"/>
	</div>
</div>


