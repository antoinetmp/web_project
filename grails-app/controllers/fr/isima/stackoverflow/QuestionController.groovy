package fr.isima.stackoverflow



import static org.springframework.http.HttpStatus.*
import fr.isima.stackoverflow.Action.ActionType;
import grails.plugin.springsecurity.SpringSecurityService;
import grails.plugin.springsecurity.annotation.Secured;
import grails.transaction.Transactional

@Transactional(readOnly = true)
class QuestionController {
	
	SpringSecurityService springSecurityService

	def actionService

	def userService
	
	def questionService
		
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
		if(params.sort == null)
		{
			params.sort = "updateDate"
			params.order= "desc"
		}
        respond Question.list(params), model:[questionInstanceCount: Question.count(), userService: userService]
    }

    def show(Question questionInstance) {
        respond questionInstance, model:[userService: userService]
    }

	@Secured(['ROLE_ADMIN', 'ROLE_MODO', 'ROLE_USER'])
    def create() {
        respond new Question(params)
    }

    @Transactional
	@Secured(['ROLE_ADMIN', 'ROLE_MODO', 'ROLE_USER'])
    def save(Question questionInstance) {
        if (questionInstance == null) {
            notFound()
            return
        }
			
        if (questionInstance.hasErrors()) {
            respond questionInstance.errors, view:'create'
            return
        }

		questionService.create(questionInstance)
		
			
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])
                redirect questionInstance
            }
            '*' { respond questionInstance, [status: CREATED] }
        }
    }
	
	def changeLang() {
		
		return
	}

	@Secured(['ROLE_ADMIN', 'ROLE_MODO', 'ROLE_USER'])
    def edit(Question questionInstance) {
		if(questionInstance != null && (User.load(userService.getCreationUser(questionInstance).id)
			 == User.load(springSecurityService.currentUser.id)
			 || springSecurityService.currentUser.isAdminOrModo()))
        {
			respond questionInstance
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
	def update(Question questionInstance) {
		if((User.load(userService.getCreationUser(questionInstance).id)
			== User.load(springSecurityService.currentUser.id)
			|| springSecurityService.currentUser.isAdminOrModo()))
		{
	        if (questionInstance == null) {
	            notFound()
	            return
	        }
			
	        if (questionInstance.hasErrors()) {
	            respond questionInstance.errors, view:'edit'
	            return
	        }
	
			questionService.update(questionInstance)
			
	        request.withFormat {
	            form multipartForm {
	                flash.message = message(code: 'default.updated.message', args: [message(code: 'Question.label', default: 'Question'), questionInstance.id])
	                redirect questionInstance
	            }
	            '*'{ respond questionInstance, [status: OK] }
	        }
		}
		else
		{
			request.withFormat {
				form multipartForm {
					flash.message = message(code: 'default.deleted.message', args: [message(code: 'Question.label', default: 'Question'), questionInstance.id])
					redirect action:"index", method:"GET"
				}
				'*'{ render status: NO_CONTENT }
			}
		}
    }

    @Transactional
	@Secured(['ROLE_ADMIN', 'ROLE_MODO', 'ROLE_USER'])
    def delete(Question questionInstance) {
		if((User.load(userService.getCreationUser(questionInstance).id)
			== User.load(springSecurityService.currentUser.id)
			|| springSecurityService.currentUser.isAdminOrModo()))
		{
	        if (questionInstance == null) {
	            notFound()
	            return
	        }
	
			questionService.delete(questionInstance)
	
	        request.withFormat {
	            form multipartForm {
	                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Question.label', default: 'Question'), questionInstance.id])
	                redirect action:"index", method:"GET"
	            }
	            '*'{ render status: NO_CONTENT }
	        }
		}
		else
		{
			request.withFormat {
				form multipartForm {
					flash.message = message(code: 'default.deleted.message', args: [message(code: 'Question.label', default: 'Question'), questionInstance.id])
					redirect action:"index", method:"GET"
				}
				'*'{ render status: NO_CONTENT }
			}
		}
		
    }

	@Transactional
	@Secured(['ROLE_ADMIN', 'ROLE_MODO', 'ROLE_USER'])
	def plusVote(Question questionInstance) {
		if (questionInstance == null) {
            notFound()
            return
        }
		
		if (!questionService.voteIsPossible(questionInstance))
		{
			request.withFormat {
	            form multipartForm {
	                flash.message = message(code: 'default.already.voted', default: 'You have already voted')
	                redirect controller:"question", action:"show", id:questionInstance.id, method:"GET"
	            }
	             '*'{ render status: NO_CONTENT }
	        }
			return
		}

		questionService.plusVote(questionInstance)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Question.label', default: 'Question'), questionInstance.id])
                redirect controller:"question", action:"show", id:questionInstance.id, method:"GET"
            }
             '*'{ render status: NO_CONTENT }
        }
	}
	
	@Transactional
	@Secured(['ROLE_ADMIN', 'ROLE_MODO', 'ROLE_USER'])
	def minusVote(Question questionInstance) {
		if (questionInstance == null) {
			notFound()
			return
		}
		
		
		if (!questionService.voteIsPossible(questionInstance))
		{
			request.withFormat {
				form multipartForm {
					flash.message = message(code: 'default.already.voted', default: 'You have already voted')
					redirect controller:"question", action:"show", id:questionInstance.id, method:"GET"
				}
				 '*'{ render status: NO_CONTENT }
			}
			return
		}
		
		questionService.minusVote(questionInstance)
		
		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.updated.message', args: [message(code: 'Question.label', default: 'Question'), questionInstance.id])
				redirect controller:"question", action:"show", id:questionInstance.id, method:"GET"
			}
			 '*'{ render status: NO_CONTENT }
		}
	}
	
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
