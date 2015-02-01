<%@ page import="fr.isima.stackoverflow.Badge" %>



<div class="form-group fieldcontain ${hasErrors(bean: badgeInstance, field: 'name', 'error')} required">
	<label for="name" class="col-sm-2 control-label">
		<g:message code="badge.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
     	<g:textField name="name" required="" class="form-control" value="${badgeInstance?.name}"/>
     </div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: badgeInstance, field: 'category', 'error')} ">
	<label for="category" class="col-sm-2 control-label">
		<g:message code="badge.category.label" default="Category" />
		
	</label>
	<div class="col-sm-10">
     	<g:select id="category" name="category.id" class="form-control" from="${fr.isima.stackoverflow.Category.list()}" optionKey="id" value="${badgeInstance?.category?.id}" noSelection="['null': '']"/>
     </div>
	
</div>

<div class="form-group fieldcontain ${hasErrors(bean: badgeInstance, field: 'urlImage', 'error')} ">
	<label for="urlImage" class="col-sm-2 control-label">
		<g:message code="badge.urlImage.label" default="Url Image" />
		
	</label>
	<div class="col-sm-10">
     	<g:textField name="urlImage" class="form-control" value="${badgeInstance?.urlImage}"/>
     </div>
	

</div>

<div class="form-group fieldcontain ${hasErrors(bean: badgeInstance, field: 'min', 'error')} required">
	<label for="min" class="col-sm-2 control-label">
		<g:message code="badge.min.label" default="Min" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
     	<g:field name="min" type="number" class="form-control" value="${badgeInstance.min}" required=""/>
     </div>
	
</div>


