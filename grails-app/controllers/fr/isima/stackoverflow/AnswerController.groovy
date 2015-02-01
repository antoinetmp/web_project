package fr.isima.stackoverflow



import static org.springframework.http.HttpStatus.*
import fr.isima.stackoverflow.Action.ActionType;
import grails.plugin.springsecurity.SpringSecurityService;
import grails.plugin.springsecurity.annotation.Secured;
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AnswerController {

	SpringSecurityService springSecurityService
	
	def actionService
	
	def answerService
	
	def userService
	
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	def questionInstance
	def questionId

	@Secured(['ROLE_ADMIN', 'ROLE_MODO', 'ROLE_USER'])
    def create() {
		questionInstance = Question.get(params.long('questionId'))
		questionId = params.questionId
        respond new Answer(params)
    }

    @Transactional
	@Secured(['ROLE_ADMIN', 'ROLE_MODO', 'ROLE_USER'])
    def save(Answer answerInstance) {
        if (answerInstance == null) {
            notFound()
            return
        }
		
        if (answerInstance.hasErrors()) {
            respond answerInstance.errors, view:'create'
            return
        }
		
		answerService.create(answerInstance, questionInstance)
		
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'answer.label', default: 'Answer'), answerInstance.id])
                redirect controller:"question", action:"show", id:questionId, method:"GET"
            }
            '*' { respond answerInstance, [status: CREATED] }
        }
    }

	@Secured(['ROLE_ADMIN', 'ROLE_MODO', 'ROLE_USER'])
    def edit(Answer answerInstance) {
		if(answerInstance != null && (User.load(userService.getCreationUser(answerInstance).id)
			== User.load(springSecurityService.currentUser.id)
			|| springSecurityService.currentUser.isAdminOrModo()))
		{
			questionId = params.questionId
	        respond answerInstance
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
    def update(Answer answerInstance) {
		if((User.load(userService.getCreationUser(answerInstance).id)
			== User.load(springSecurityService.currentUser.id)
			|| springSecurityService.currentUser.isAdminOrModo()))
		{
	        if (answerInstance == null) {
	            notFound()
	            return
	        }
			
	        if (answerInstance.hasErrors()) {
	            respond answerInstance.errors, view:'edit'
	            return
	        }
	
			answerService.update(answerInstance)
			
	        request.withFormat {
	            form multipartForm {
	                flash.message = message(code: 'default.updated.message', args: [message(code: 'Answer.label', default: 'Answer'), answerInstance.id])
	                redirect controller:"question", action:"show", id:questionId, method:"GET"
	            }
	            '*'{ respond answerInstance, [status: OK] }
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
    def delete(Answer answerInstance) {
		if((User.load(userService.getCreationUser(answerInstance).id)
			== User.load(springSecurityService.currentUser.id)
			|| springSecurityService.currentUser.isAdminOrModo()))
		{
	        if (answerInstance == null) {
	            notFound()
	            return
	        }
			
			questionId = params.questionId
			
			answerService.delete(answerInstance)
			
	        request.withFormat {
	            form multipartForm {
	                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Answer.label', default: 'Answer'), answerInstance.id])
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
	
	@Transactional
	@Secured(['ROLE_ADMIN', 'ROLE_MODO', 'ROLE_USER'])
	def plusVote(Answer answerInstance) {
		if (answerInstance == null) {
			notFound()
			return
		}

		questionId = params.questionId
			
		if (!answerService.voteIsPossible(answerInstance))
		{
			request.withFormat {
				form multipartForm {
					flash.message = message(code: 'default.already.voted', default: 'You have already voted')
					redirect controller:"question", action:"show", id:questionId, method:"GET"
				}
				 '*'{ render status: NO_CONTENT }
			}
			return
		}
							
		answerService.plusVote(answerInstance)
		
		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.updated.message', args: [message(code: 'Answer.label', default: 'Answer'), answerInstance.id])
				redirect controller:"question", action:"show", id:questionId, method:"GET"
			}
			'*'{ render status: NO_CONTENT }
		}
	}
	
	@Transactional
	@Secured(['ROLE_ADMIN', 'ROLE_MODO', 'ROLE_USER'])
	def minusVote(Answer answerInstance) {
		if (answerInstance == null) {
			notFound()
			return
		}

		questionId = params.questionId
		
		if (!answerService.voteIsPossible(answerInstance))
		{
			request.withFormat {
				form multipartForm {
					flash.message = message(code: 'default.already.voted', default: 'You have already voted')
					redirect controller:"question", action:"show", id:questionId, method:"GET"
				}
				 '*'{ render status: NO_CONTENT }
			}
			return
		}

		answerService.minusVote(answerInstance)
		
		request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Answer.label', default: 'Answer'), answerInstance.id])
                redirect controller:"question", action:"show", id:questionId, method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
	}

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'answer.label', default: 'Answer'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
