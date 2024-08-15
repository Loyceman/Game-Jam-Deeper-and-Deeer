extends Ennemy

var target : Player = null
var aiming : bool = true

func _ready():
	$HitZone.body_entered.connect(hitZone)
	$HitZone.body_exited.connect(noHitZone)
	$NearZone.body_entered.connect(noHitZone)

func _physics_process(delta):
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
