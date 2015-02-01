package fr.isima.stackoverflow

class Badge {

	String name
	String urlImage
	int min
	Category category
		
	static hasMany = [users:User]
	
	static belongsTo = [User]
	
	static constraints = {
		name unique: true
		category nullable: true
		urlImage nullable: true
	}
}
