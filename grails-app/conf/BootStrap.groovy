import fr.isima.stackoverflow.Role
import fr.isima.stackoverflow.User
import fr.isima.stackoverflow.UserRole

class BootStrap {

    def init = { servletContext ->
      def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true) 
	  def userRole = new Role(authority: 'ROLE_USER').save(flush: true)
	  def modoRole = new Role(authority: 'ROLE_MODO').save(flush: true)
	  def testUser = new User(username: 'admin', password: 'admin', accountExpired: false, 
		  					  accountLocked: false, passwordExpired: false,
							  firstname: 'antoine', lastname:'Cornelle', reputation: 0) 
	  testUser.save(flush: true)
	  
	  def userWithRole = new UserRole(user: testUser, role: adminRole)
	  userWithRole.save(flush: true, insert: true)
	 
    }
	
    def destroy = {
    }
}
