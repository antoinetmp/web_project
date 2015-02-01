package fr.isima.stackoverflow

import grails.transaction.Transactional

@Transactional
class BadgeService {

	def userService
	
	def save(Badge b)
	{
		b.save flush:true
	}
		
	def delete(Badge b)
	{
		for(u in b.users)
		{
			userService.removeBadge(u, b)
		}
		b.delete flush:true
	}
	
	def checkBadgesForUser(User u)
	{
		def badges = Badge.getAll()
		badges.removeAll(u.badges)
		for(badge in badges)
		{
			if(badge.category != null)
			{
				def nbPosts = userService.getNbPostsForCategory(u, badge.category)
				if( nbPosts >= badge.min)
				{
					userService.addBadge(u, badge)
				}
			}
			else
			{
				if(u.reputation >= badge.min)
				{
					userService.addBadge(u, badge)
				}
			}
		}
	}
}
