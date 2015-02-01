package fr.isima.stackoverflow



import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured;
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def userService
	
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond User.list(params), model:[userInstanceCount: User.count(), userService: userService]
    }

    def show(User userInstance) {
        respond userInstance, model:[userService: userService]
    }

    def create() {
        respond new User(params)
    }

    @Transactional
    def save(User userInstance) {
		

        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view:'create'
            return
        }
		
		userService.create(userInstance)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*' { respond userInstance, [status: CREATED] }
        }
    }

	@Secured(['ROLE_ADMIN', 'ROLE_MODO', 'ROLE_USER'])
    def edit(User userInstance) {
        respond userInstance
    }

    @Transactional
	@Secured(['ROLE_ADMIN', 'ROLE_MODO', 'ROLE_USER'])
    def update(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view:'edit'
            return
        }

		userService.save(userInstance)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*'{ respond userInstance, [status: OK] }
        }
    }
	
	@Transactional
	@Secured(['ROLE_ADMIN'])
	def makeModo(User userInstance) {
		if (userInstance == null) {
			notFound()
			return
		}

		if (userInstance.hasErrors()) {
			respond userInstance.errors, view:'index'
			return
		}

		userService.makeModo(userInstance)

		request.withFormat {
			'*' {
				flash.message = message(code: 'default.updated.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
				redirect action: "index", method: "GET"
			}
		}
	}
	
	@Transactional
	@Secured(['ROLE_ADMIN'])
	def removeModo(User userInstance) {
		if (userInstance == null) {
			notFound()
			return
		}

		if (userInstance.hasErrors()) {
			respond userInstance.errors, view:'index'
			return
		}

		userService.removeModo(userInstance)

		request.withFormat {
			'*' {
				flash.message = message(code: 'default.updated.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
				redirect action: "index", method: "GET"
			}
		}
	}

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
