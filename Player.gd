extends CharacterBody3D

var activeTrigger = null
var speed = 0.2
var vel = Vector3.ZERO
var acceleration = Vector3.ZERO
var trigger_record = 0.00
var lean = 0.00
var tilt = 0.00
var physLean = 0.00


func _ready():
	pass
	



func _process(_delta):
	if activeTrigger != "R":
		if Input.get_action_strength("trigger_R") != 1:
			if Input.get_action_strength("trigger_L") > trigger_record:
				acceleration.x += Input.get_action_strength("trigger_L") - trigger_record
				print("pulled past record")
				
				
				trigger_record = Input.get_action_strength("trigger_L")
			else:
				acceleration.x *= 0.99
				#print("not past record")
				if Input.get_action_strength("trigger_L") == 1.00:
					activeTrigger = "R"
					trigger_record = 0.00
	if activeTrigger != "L":
		if Input.get_action_strength("trigger_L") != 1:
			if Input.get_action_strength("trigger_R") > trigger_record:
				acceleration.x += Input.get_action_strength("trigger_R") - trigger_record
				print("pulled past record")
				
				
				trigger_record = Input.get_action_strength("trigger_R")
			else:
				acceleration.x *= 0.99
				#print("not past record")
				if Input.get_action_strength("trigger_R") == 1.00:
					activeTrigger = "L"
					trigger_record = 0.00
		
	else:
		print("oop")
	if lean > Input.get_axis("move_right", "move_left") * 35:
		lean -= 2
	if lean < Input.get_axis("move_right", "move_left") * 35:
		lean += 2
	
	if lean > 35:
			lean = 35
	if lean < -35:
		lean = -35
	

func _physics_process(delta):
	tilt += acceleration.x * Input.get_axis("move_right", "move_left") / 20
	set_rotation_degrees(Vector3(lean, tilt, 0))
	var movement_dir = transform.basis * Vector3((-acceleration.x * 10) * speed, 0 , 0)	
	velocity = movement_dir
	move_and_slide()
	


