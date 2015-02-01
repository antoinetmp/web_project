package fr.isima.stackoverflow

import grails.transaction.Transactional

@Transactional
class CategoryService {

	def questionService
	
	def badgeService
	
    def save(Category c)
	{
		c.save flush:true
	}
	
	def delete(Category c)
	{
		for(q in c.questions)
		{
			questionService.removeCategory(q, c)
		}
		for(b in c.badges)
		{
			c.badges.remove(b)
			badgeService.delete(b)
		}
		
		c.delete flush:true
	}
}
