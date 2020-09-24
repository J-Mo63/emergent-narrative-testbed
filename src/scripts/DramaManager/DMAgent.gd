class_name DMAgent
extends GoapAgent

func _init(owner):
	goal_state = {
		HomeStates.StateConditions.DOOR_OPENED: true,
	}
	actions = [
		KnockAction
	]
	.setup(owner, HomeStates.StateConditions.size())

func generate_current_state():
	var current_state = blank_state.duplicate()
	var agent = owner.get_tree().get_nodes_in_group("agent")[0]
	current_state[HomeStates.StateConditions.IS_HUNGRY] = agent.blackboard.get("hunger") <= 0
	current_state[HomeStates.StateConditions.IS_SLEEPY] = agent.blackboard.get("energy") <= 0
	current_state[HomeStates.StateConditions.DOOR_UNCHECKED] = get_agent_profile(agent).any_doors_knocked()
	current_state[HomeStates.StateConditions.DOOR_OPENED] = get_agent_profile(agent).any_doors_opened()
	current_state[HomeStates.StateConditions.IS_BORED] = not current_state[HomeStates.StateConditions.IS_SLEEPY] and not current_state[HomeStates.StateConditions.IS_HUNGRY]
	current_state[HomeStates.StateConditions.KNOWS_FOOD] = check_agent_memory(agent, "food")
	current_state[HomeStates.StateConditions.KNOWS_BED] = check_agent_memory(agent, "bed")
	current_state[HomeStates.StateConditions.KNOWS_CHAIR] = check_agent_memory(agent, "chair")
	current_state[HomeStates.StateConditions.KNOWS_DOOR] = check_agent_memory(agent, "door")
	return current_state

func get_agent_profile(agent):
	return agent.behaviour_algorithm.agent_profile

func check_agent_memory(agent, group_name):
	return true if agent.blackboard.get(group_name) else false
