package fr.isima.stackoverflow

class Question extends Post {

	String title
	
	static hasMany = [answers:Answer, categories:Category]
	
    static constraints = {
		
    }
	
}
