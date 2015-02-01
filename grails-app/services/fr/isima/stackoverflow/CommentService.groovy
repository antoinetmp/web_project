package fr.isima.stackoverflow

import fr.isima.stackoverflow.Action.ActionType;
import grails.transaction.Transactional

@Transactional
class CommentService {

	def springSecurityService
	
	def actionService
	
	def userService
	
    def save(Comment c)
	{
		c.save flush:true
	}
	
	def create(Comment c, Post p)
	{
		c.creationDate = new Date()
		c.updateDate = new Date()
		c.mark = 0
		c.post = p
		save(c)
		
		def currentUser = springSecurityService.currentUser
		def action = new Action(post: c, user: currentUser,
			date: new Date(), type: ActionType.CREATE_COMMENT)
		actionService.save(action)
		userService.incrementeReputation(currentUser)
	}
	
	def update(Comment c)
	{
		c.updateDate = new Date()
		
		save(c)
		
		def action = new Action(post: c, user: springSecurityService.currentUser,
			date: new Date(), type: ActionType.EDIT_COMMENT)
		actionService.save(action)
	}
	
	def delete(Comment c)
	{
		c.delete flush:true
	}
}
