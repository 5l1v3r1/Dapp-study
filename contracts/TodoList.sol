pragma solidity ^0.5.0;

contract TodoList {
	uint public taskCount = 0;

	// model the task
	struct Task {
		uint id;
		string content;
		bool completed;
	}

	event TaskCreated(
		uint id,
		string content,
		bool completed
		);
	event TaskCompleted(
		uint id,
		bool completed
		);

	// mapping to access the storage
	// todoList.tasks() access the items
	mapping(uint => Task) public tasks; // using "public" so SC will provide a function for free

	// put Task struct into mapping
	function createTask(string memory _content) public {
		taskCount ++;
		//create Task item
		tasks[taskCount] = Task(taskCount, _content, false);

		// Broadcast an event that task created
		emit TaskCreated(taskCount, _content, false);
	}

	function toggleCompleted(uint _id) public {
		Task memory _task = tasks[_id];
		_task.completed = !_task.completed;
		tasks[_id] = _task;
		emit TaskCompleted(_id, _task.completed);
	}

	//add some init tasks using contructor
	constructor() public {
		createTask("Init task using constructor");
	}
}