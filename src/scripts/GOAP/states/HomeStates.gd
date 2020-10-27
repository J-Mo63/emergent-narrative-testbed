class_name HomeStates
extends GoapStates

enum StateConditions {
	IS_HUNGRY,
	IS_SLEEPY,
	DOOR_KNOCKED,
	DOOR_OPENED,
	KNOWS_FOOD,
	KNOWS_BED,
	KNOWS_CHAIR,
	KNOWS_DOOR,
}

static func generate_current_state(owner):
	var current_state = .generate_base_state(StateConditions.size())
	current_state[StateConditions.IS_HUNGRY] = owner.blackboard.get("hunger") <= 0
	current_state[StateConditions.IS_SLEEPY] = owner.blackboard.get("energy") <= 0
	current_state[StateConditions.DOOR_KNOCKED] = any_doors_knocked(owner)
	current_state[StateConditions.DOOR_OPENED] = any_doors_opened(owner)
	current_state[StateConditions.KNOWS_FOOD] = .check_agent_memory(owner, "food")
	current_state[StateConditions.KNOWS_BED] = .check_agent_memory(owner, "bed")
	current_state[StateConditions.KNOWS_CHAIR] = .check_agent_memory(owner, "chair")
	current_state[StateConditions.KNOWS_DOOR] = .check_agent_memory(owner, "door")
	return current_state

static func any_doors_knocked(owner) -> bool:
	if owner.blackboard.get("door"):
		for door in owner.blackboard.get("door"):
			if door.knocked:
				return true
	return false

static func any_doors_opened(owner) -> bool:
	if owner.blackboard.get("door"):
		for door in owner.blackboard.get("door"):
			if door.opened:
				return true
	return false
