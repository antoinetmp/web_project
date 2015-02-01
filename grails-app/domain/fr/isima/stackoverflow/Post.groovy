package fr.isima.stackoverflow

class Post {

	String content
	int mark
	Date creationDate
	Date updateDate
	
	static hasMany = [comments:Comment, actions:Action]
	
    static constraints = {
		content size: 1..5000
		creationDate nullable: true
		updateDate nullable: true
    }
	
	static mapping = {
		tablePerHierarchy false
	}
	
	static boolean exists(long postId) {
		Post.where {
			id == postId
		}.count() > 0
	}
	
	
}
