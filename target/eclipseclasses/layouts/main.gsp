<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Grails"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">
  		<asset:stylesheet src="application.css"/>
		<asset:javascript src="application.js"/>
		<g:layoutHead/>
	</head>
	<body>
		
		<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
			<div class="navbar-collapse collapse">
				<ul class="nav nav-tabs  navbar-nav nav-left ">
					<li>
						<div id="grailsLogo" role="banner">
							<a href="http://grails.org">
								<asset:image src="grails_logo.png" alt="Grails"/>
							</a>
						</div>
					</li>
					<li>
						<a class="home" href="${createLink(uri: '/')}">
							<i class="glyphicon glyphicon-home"></i>
							<g:message code="default.home.label"/>
						</a>
					</li>
					<li>
						<g:link controller="user" class="index" action="index">
							<i class="glyphicon glyphicon-user"></i>
							<g:message code="default.users.label" default="Users" />
						</g:link>
					</li>
					<li>
						<g:link controller="badge" class="index" action="index">
							<i class="glyphicon glyphicon-star"></i>
							<g:message code="default.badges.label" default="Badges" />
						</g:link>
					</li>
					<li>
						<g:link controller="category" class="index" action="index">
							<i class="glyphicon glyphicon-tags"></i>
							<g:message code="default.categories.label" default="Categories" />
						</g:link>
					</li>
					
					<sec:ifLoggedIn>
						<li>
							<g:link controller="user" class="show" action="show" id="${sec.loggedInUserInfo(field:"id")}" >
								<i class="glyphicon glyphicon-search"></i>
								<g:message code="default.user.profile.label" default="My Profile" />
							</g:link>
						</li>
					</sec:ifLoggedIn>
				</ul>
				<ul class="nav nav-tabs navbar-nav navbar-right">
					<locale:selector />
					<sec:ifLoggedIn>
						<li>
							<g:remoteLink class="logout" controller="logout" method="post" asynchronous="false" onSuccess="location.reload()">
								<i class="glyphicon glyphicon-log-out"></i>
								<g:message code="logout.label" default="Logout" />
							</g:remoteLink>
						</li>
					</sec:ifLoggedIn>
					<sec:ifNotLoggedIn>
						<li>
							<g:link controller="login" class="index" action="auth">
								<i class="glyphicon glyphicon-log-in"></i>
								<g:message code="login.label" default="Login" />
							</g:link>
						</li>
						<li>
							<g:link controller="user" class="create" action="create">
								<g:message code="sign.in.label" default="Sign in" />
							</g:link>
						</li>
					</sec:ifNotLoggedIn>
				</ul>
			</div>
		</nav>
		<div class="container">
			<g:layoutBody/>
		</div>
		<nav class="navbar navbar-default navbar-fixed-bottom">
		  <div class="footer" role="contentinfo">
			&copy; Copyright - Antoine CORNELLE & Adrien POURCHER-PORTALIER
		  </div>
		</nav>
		
		
		<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
	</body>
</html>
