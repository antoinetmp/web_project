package fr.isima.stackoverflow

import fr.isima.stackoverflow.Action.ActionType;
import grails.transaction.Transactional

@Transactional
class UserService {

	def actionService
	
	def badgeService
	
	def springSecurityService
	
	def save(User u)
	{
		u.save flush:true
	}
	
	def create(User u)
	{
		u.reputation = 0
		save(u)
		def userWithRole = new UserRole(user: u, role: Role.findByAuthority("ROLE_USER"))
		userWithRole.save(flush: true, insert: true)
		
	}
	
	def makeModo(User u)
	{
		def userWithRole = new UserRole(user: u, role: Role.findByAuthority("ROLE_MODO"))
		userWithRole.save(flush: true, insert: true)
	}
	
	def removeModo(User u)
	{
		def userWithRole = UserRole.get(u.id, Role.findByAuthority("ROLE_MODO").id)
		userWithRole.delete flush:true
	}
	
	def delete(User u)
	{
		u.delete flush:true
	}
	
    User getCreationUser(Post p)
	{
		User.load(actionService.getCreationActionByPost(p).user.id)
	}
	
	int getNbQuestions(User u)
	{
		u.actions.findAll { it.type == ActionType.CREATE_QUESTION }.size()
	}
	
	int getNbAnswers(User u)
	{
		u.actions.findAll { it.type == ActionType.CREATE_ANSWER }.size()
	}
	
	int getNbComments(User u)
	{
		u.actions.findAll { it.type == ActionType.CREATE_COMMENT }.size()
	}
	
	int getNbPostsForCategory(User u, Category c)
	{
		def nb = u.actions.findAll {
			(it.type == ActionType.CREATE_QUESTION
			&& it.post.categories?.contains(Category.load(c.id)) ) || 
			(it.type == ActionType.CREATE_ANSWER
			&& it.post.question.categories?.contains(Category.load(c.id)))
		}.size()
	}
	
	
	def incrementeReputation(User u)
	{
		u.reputation++
		save(u)
		badgeService.checkBadgesForUser(u)
	}
	
	def removeBadge(User u, Badge b)
	{
		u.badges.remove(b)
		save(u)
	}
	
	def addBadge(User u, Badge b)
	{
		u.badges.add(b)
		save(u)
	}
	
	User getCurrentUser()
	{
		springSecurityService.currentUser
	}
}
