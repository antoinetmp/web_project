package fr.isima.stackoverflow



import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured;
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ActionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def user
	
	def actionService
	
	def springSecurityService
	
	@Secured(['ROLE_ADMIN', 'ROLE_MODO', 'ROLE_USER'])
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
		
		if(params.userId != null)
			user = User.load(params.userId)
		
        respond Action.findAllByUser( user , params ), model:[actionInstanceCount: Action.countByUser(user)]
    }
	
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'action.label', default: 'Action'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
