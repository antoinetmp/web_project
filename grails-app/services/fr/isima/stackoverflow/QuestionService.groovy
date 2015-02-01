package fr.isima.stackoverflow

import fr.isima.stackoverflow.Action.ActionType;
import grails.transaction.Transactional

@Transactional
class QuestionService {

	def springSecurityService
	
	def actionService
	
	def userService
	
    def save(Question q)
	{
		q.save flush:true
	}
	
	def create(Question q)
	{
		q.creationDate = new Date()
		q.updateDate = new Date()
		q.mark = 0
		save(q)
		
		def currentUser = springSecurityService.currentUser
		
		def action = new Action(post: q, user: springSecurityService.currentUser,
			date: new Date(), type: ActionType.CREATE_QUESTION)
		actionService.save(action)

		userService.incrementeReputation(currentUser)

	}
	
	def update(Question q)
	{
		q.updateDate = new Date()
		save(q)
		def action = new Action(post: q, user: springSecurityService.currentUser,
			date: new Date(), type: ActionType.EDIT_QUESTION)
		actionService.save(action)
	}
	
	def delete(Question q)
	{
		q.delete flush:true
	}
	
	def plusVote(Question q)
	{
		q.mark++
		save(q)
		
		def action = new Action(post: q, user: springSecurityService.currentUser,
			date: new Date(), type: ActionType.UP_VOTE_QUESTION)
		actionService.save(action)
	}
	
	def minusVote(Question q)
	{
		q.mark--
		save(q)
			
		def action = new Action(post: q, user: springSecurityService.currentUser,
			date: new Date(), type: ActionType.DOWN_VOTE_QUESTION)
		actionService.save(action)
	}
	
	boolean voteIsPossible(Question q)
	{
		def user = springSecurityService.currentUser
		(!actionService.exists(user, q, ActionType.UP_VOTE_QUESTION)
		&& !actionService.exists(user, q, ActionType.DOWN_VOTE_QUESTION))
	}
	
	def removeCategory(Question q, Category c)
	{
		q.categories.remove(c)
		save(q)
	}
}
