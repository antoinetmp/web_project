package fr.isima.stackoverflow

class Comment extends Post {

	static belongsTo = [post:Post]
		
    static constraints = {
		post nullable: true
		
    }
}
