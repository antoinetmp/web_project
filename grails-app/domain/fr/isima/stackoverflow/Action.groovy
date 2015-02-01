package fr.isima.stackoverflow

class Action {

	enum ActionType
	{
		CREATE_QUESTION,
		EDIT_QUESTION,
		DELETE_QUESTION,
		UP_VOTE_QUESTION,
		DOWN_VOTE_QUESTION,
		CREATE_ANSWER,
		EDIT_ANSWER,
		DELETE_ANSWER,
		UP_VOTE_ANSWER,
		DOWN_VOTE_ANSWER,
		CREATE_COMMENT,
		EDIT_COMMENT,
		DELETE_COMMENT
		
	}
	
	ActionType type
	
	Date date
	
	static belongsTo = [post:Post, user:User]
	
    static constraints = {
		date nullable: true
    }
}

