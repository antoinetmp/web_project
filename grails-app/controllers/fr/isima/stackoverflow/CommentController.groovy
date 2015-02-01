package fr.isima.stackoverflow



import static org.springframework.http.HttpStatus.*
import fr.isima.stackoverflow.Action.ActionType;
import grails.plugin.springsecurity.SpringSecurityService;
import grails.plugin.springsecurity.annotation.Secured;
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CommentController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def commentService
	
	def postInstance
	
	def questionId
	
	def userService
	
	SpringSecurityService springSecurityService

	@Secured(['ROLE_ADMIN', 'ROLE_MODO', 'ROLE_USER'])
    def create() {
		postInstance = Post.get(params.long('post'))
		questionId = params.questionId
        respond new Comment(params)
    }

    @Transactional
	@Secured(['ROLE_ADMIN', 'ROLE_MODO', 'ROLE_USER'])
    def save(Comment commentInstance) {
        if (commentInstance == null) {
            notFound()
            return
        }

        if (commentInstance.hasErrors()) {
            respond commentInstance.errors, view:'create'
            return
        }

		commentService.create(commentInstance, postInstance)
		
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'comment.label', default: 'Comment'), commentInstance.id])
                redirect controller:"question", action:"show", id:questionId, method:"GET"
            }
            '*' { respond commentInstance, [status: CREATED] }
        }
    }

	@Secured(['ROLE_ADMIN', 'ROLE_MODO', 'ROLE_USER'])
    def edit(Comment commentInstance) {
		if(commentInstance != null && (User.load(userService.getCreationUser(commentInstance).id)
			== User.load(springSecurityService.currentUser.id)
			|| springSecurityService.currentUser.isAdminOrModo()))
		{
			questionId = params.questionId
			respond commentInstance
		}
		else
		{
			request.withFormat {
				form multipartForm {
					flash.message = message(code: 'default.deleted.message', args: [message(code: 'Question.label', default: 'Question'), questionInstance.id])
					redirect controller:"question", action:"index", method:"GET"
				}
				'*'{ render status: NO_CONTENT }
			}
		}
		
    }

    @Transactional
	@Secured(['ROLE_ADMIN', 'ROLE_MODO', 'ROLE_USER'])
    def update(Comment commentInstance) {
		if((User.load(userService.getCreationUser(commentInstance).id)
			== User.load(springSecurityService.currentUser.id)
			|| springSecurityService.currentUser.isAdminOrModo()))
		{
			if (commentInstance == null) {
	            notFound()
	            return
	        }
			
	        if (commentInstance.hasErrors()) {
	            respond commentInstance.errors, view:'edit'
	            return
	        }
	
			commentService.update(commentInstance)
	
	        request.withFormat {
	            form multipartForm {
	                flash.message = message(code: 'default.updated.message', args: [message(code: 'Comment.label', default: 'Comment'), commentInstance.id])
	                 redirect controller:"question", action:"show", id:questionId, method:"GET"
	            }
	            '*'{ respond commentInstance, [status: OK] }
	        }
		}
		else
		{
			request.withFormat {
				form multipartForm {
					flash.message = message(code: 'default.deleted.message', args: [message(code: 'Question.label', default: 'Question'), questionInstance.id])
					redirect controller:"question", action:"index", method:"GET"
				}
				'*'{ render status: NO_CONTENT }
			}
		}
        
    }

    @Transactional
	@Secured(['ROLE_ADMIN', 'ROLE_MODO', 'ROLE_USER'])
    def delete(Comment commentInstance) {
		if((User.load(userService.getCreationUser(commentInstance).id)
			== User.load(springSecurityService.currentUser.id)
			|| springSecurityService.currentUser.isAdminOrModo()))
		{
	        if (commentInstance == null) {
	            notFound()
	            return
	        }
	
			questionId = params.questionId
			
			commentService.delete(commentInstance)
			
	        request.withFormat {
	            form multipartForm {
	                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Comment.label', default: 'Comment'), commentInstance.id])
	                redirect controller:"question", action:"show", id:questionId, method:"GET"
	            }
	            '*'{ render status: NO_CONTENT }
	        }
		}
		else
		{
			request.withFormat {
				form multipartForm {
					flash.message = message(code: 'default.deleted.message', args: [message(code: 'Question.label', default: 'Question'), questionInstance.id])
					redirect controller:"question", action:"index", method:"GET"
				}
				'*'{ render status: NO_CONTENT }
			}
		}
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
