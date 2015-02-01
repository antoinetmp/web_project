<%@ page import="fr.isima.stackoverflow.Category" %>



<div class="form-group fieldcontain ${hasErrors(bean: categoryInstance, field: 'label', 'error')} required">
	<label for="label" class="col-sm-2 control-label">
		<g:message code="category.label.label" default="Label" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
		<g:textField name="label" class="form-control" required="" value="${categoryInstance?.label}"/>
	</div>
</div>


