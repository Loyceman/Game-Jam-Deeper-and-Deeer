extends Ennemy

var target  = null
var aiming : bool = true

func _ready():
	set_rotation_degrees(180)
	# à sa creation, soit la queue est vers le bas soit vers le haut 
	var tailUp = randi_range(0,1)
	if(tailUp == 1):
		scale.y = -scale.y
	else :
		scale.y = scale.y
		
	$HitZone.body_entered.connect(hitZone)
	$HitZone.body_exited.connect(noHitZone)
	$NearZone.body_entered.connect(noHitZone)

func _physics_process(delta):
	speed = Global.addSpeed + init_speed
	if aiming && target != null :
		aim()
	move_and_collide(velocity*delta)

func aim():
	look_at(target.position)
	velocity = position.direction_to(target.position) * speed

func hitZone(body : Node2D):
	if(body.has_method("isPlayer")):
		aiming = true
		target = body
		
func noHitZone(body : Node2D):
	if(body.has_method("isPlayer")):
		aiming = false
		target = null
