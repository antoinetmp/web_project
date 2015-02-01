package fr.isima.stackoverflow



import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured;
import grails.transaction.Transactional

@Transactional(readOnly = true)
class BadgeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def badgeService
	
	def userService
	
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Badge.list(params), model:[badgeInstanceCount: Badge.count(), userService: userService]
    }

	@Secured(['ROLE_ADMIN'])
    def create() {
        respond new Badge(params)
    }

    @Transactional
	@Secured(['ROLE_ADMIN'])
    def save(Badge badgeInstance) {
        if (badgeInstance == null) {
            notFound()
            return
        }

        if (badgeInstance.hasErrors()) {
            respond badgeInstance.errors, view:'create'
            return
        }

		badgeService.save(badgeInstance)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'badge.label', default: 'Badge'), badgeInstance.id])
				redirect controller:"badge", action:"index"
				
            }
            '*' { respond badgeInstance, [status: CREATED] }
        }
    }

	@Secured(['ROLE_ADMIN'])
    def edit(Badge badgeInstance) {
        respond badgeInstance
    }

    @Transactional
	@Secured(['ROLE_ADMIN'])
    def update(Badge badgeInstance) {
        if (badgeInstance == null) {
            notFound()
            return
        }

        if (badgeInstance.hasErrors()) {
            respond badgeInstance.errors, view:'edit'
            return
        }

		badgeService.save(badgeInstance)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Badge.label', default: 'Badge'), badgeInstance.id])
                redirect controller:"badge", action:"index"
            }
            '*'{ respond badgeInstance, [status: OK] }
        }
    }

    @Transactional
	@Secured(['ROLE_ADMIN'])
    def delete(Badge badgeInstance) {

        if (badgeInstance == null) {
            notFound()
            return
        }

		badgeService.delete(badgeInstance)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Badge.label', default: 'Badge'), badgeInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'badge.label', default: 'Badge'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
