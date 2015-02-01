<%@ page import="fr.isima.stackoverflow.User" %>



<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
	<label for="username" class="col-sm-2 control-label">
		<g:message code="user.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
		<g:textField class="form-control" name="username" required="" value="${userInstance?.username}"/>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
	<label for="password" class="col-sm-2 control-label">
		<g:message code="user.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
		<g:textField class="form-control" name="password" required="" value="${userInstance?.password}"/>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'firstname', 'error')} required">
	<label for="firstname" class="col-sm-2 control-label">
		<g:message code="user.firstname.label" default="Firstname" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
		<g:textField class="form-control" name="firstname" required="" value="${userInstance?.firstname}"/>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'lastname', 'error')} required">
	<label for="lastname" class="col-sm-2 control-label">
		<g:message code="user.lastname.label" default="Lastname" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
		<g:textField class="form-control" name="lastname" required="" value="${userInstance?.lastname}"/>
	</div>
</div>
