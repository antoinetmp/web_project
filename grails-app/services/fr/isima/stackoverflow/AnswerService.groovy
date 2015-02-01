package fr.isima.stackoverflow

import fr.isima.stackoverflow.Action.ActionType;
import grails.transaction.Transactional

@Transactional
class AnswerService {

	def springSecurityService
	
	def actionService
	
	def userService
	
	def badgeService
	
    def save(Answer a)
	{
		a.save flush:true
	}
	
	def create(Answer a, Question q)
	{
		a.creationDate = new Date()
		a.updateDate = new Date()
		a.mark = 0
		
		a.question = q
		
		save(a)
		
		def currentUser = springSecurityService.currentUser
		def action = new Action(post: a, user: springSecurityService.currentUser,
			date: new Date(), type: ActionType.CREATE_ANSWER)
		actionService.save(action)
		
		userService.incrementeReputation(currentUser)

	}
	
	def update(Answer a)
	{
		a.updateDate = new Date()
		save(a)
		
		def action = new Action(post: a, user: springSecurityService.currentUser,
			date: new Date(), type: ActionType.EDIT_ANSWER)

		actionService.save(action)
	}
	
	def delete(Answer a)
	{
		a.delete flush:true
	}
	
	def plusVote(Answer a)
	{
		a.mark++
		
		save(a)
		
		def action = new Action(post: a, user: springSecurityService.currentUser,
			date: new Date(), type: ActionType.UP_VOTE_ANSWER)
		
		actionService.save(action)
	}
	
	def minusVote(Answer a)
	{
		a.mark--
		save(a)
			
		def action = new Action(post: a, user: springSecurityService.currentUser,
			date: new Date(), type: ActionType.DOWN_VOTE_ANSWER)
		actionService.save(action)
	}
	
	boolean voteIsPossible(Answer a)
	{
		def user = springSecurityService.currentUser
		(!actionService.exists(user, a, ActionType.UP_VOTE_ANSWER)
		&& !actionService.exists(user, a, ActionType.DOWN_VOTE_ANSWER))
	}
	
}
