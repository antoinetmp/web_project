package fr.isima.stackoverflow

class Category {

	String label
	
	static hasMany = [questions:Question, badges:Badge]
	
	static belongsTo = Question
	
    static constraints = {
		label unique: true
    }
	
	String toString()
	{
		return label;
	}
	
}
