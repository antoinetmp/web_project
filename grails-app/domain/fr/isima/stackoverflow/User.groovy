package fr.isima.stackoverflow

import fr.isima.stackoverflow.Action.ActionType;

class User {


	transient springSecurityService

	String username
	String password
	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired
	
	String firstname
	String lastname
	
	int reputation
	
	
	static transients = ['springSecurityService']
	
	static hasMany = [actions:Action, badges:Badge]

	static constraints = {
		username blank: false, unique: true
		password blank: false
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role }
	}
	
	boolean isAdmin() {
		def roles = getAuthorities()
		for(r in roles)
		{
			if(r.authority == "ROLE_ADMIN")
			{
				return true
			}
		}
		return false
	}
	
	boolean isModo() {
		def roles = getAuthorities()
		for(r in roles)
		{
			if(r.authority == "ROLE_MODO")
			{
				return true
			}
		}
		return false
	}
	
	
	boolean isAdminOrModo() {
		def roles = getAuthorities()
		for(r in roles)
		{
			if(r.authority == "ROLE_ADMIN" || r.authority == "ROLE_MODO")
			{
				return true
			}
		}
		return false
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
	}
	
	
}
