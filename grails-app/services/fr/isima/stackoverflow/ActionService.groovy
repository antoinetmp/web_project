package fr.isima.stackoverflow

import fr.isima.stackoverflow.Action.ActionType;
import grails.transaction.Transactional

@Transactional
class ActionService {

	void removeAll(Post p, boolean flush = false) {
		if (p == null) return
			Action.where {
				post == Post.load(p.id)
			}.deleteAll()
		if (flush) { Action.withSession { it.flush() } }
	}

	void removeAll(User u, boolean flush = false) {
		if (u == null) return
			Action.where {
				user == User.load(u.id)
			}.deleteAll()
		if (flush) { Action.withSession { it.flush() } }
	}



	boolean exists(User u, Post p, ActionType t) {
		Action.where {
			user == User.load(u.id) &&
					post == Post.load(p.id) &&
					type == t
		}.count() > 0
	}

	Action getCreationActionByPost(Post p)
	{
		Action.where {
			post == Post.load(p.id) &&
					(type == ActionType.CREATE_QUESTION ||
					type == ActionType.CREATE_ANSWER ||
					type == ActionType.CREATE_COMMENT)
		}.first()
	}

	def save(Action a)
	{
		a.save flush:true
	}

	def delete(Action a)
	{
		a.delete flush:true
	}
	
}
