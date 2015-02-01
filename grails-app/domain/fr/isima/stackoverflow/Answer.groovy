package fr.isima.stackoverflow

class Answer extends Post{

	static belongsTo = [question:Question]
	
    static constraints = {
		question nullable: true
    }
}
