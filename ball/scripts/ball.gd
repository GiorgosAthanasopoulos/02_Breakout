extends RigidBody2D


# TODO: show player lives/score. 3 lives to begin. if you lose all 3 lives you lose (show message, restart game)
# TODO: add win/lose sfx
# TODO: add brick destroyed sfx


@export var toss_angle_boundary: Vector2 = Vector2(-45, 45) # clockwise, in degrees
@export var speed: int = 400


@onready var sfx_audio_stream_player_2d: AudioStreamPlayer2D = $SFXAudioStreamPlayer2D


var angle: float


func _ready() -> void:
    launch_ball()


func _process(_delta: float) -> void:
    if Input.is_action_just_pressed(&'ui_cancel'):
        position = get_viewport_rect().size / 2
        position.y += 60 # so it doesnt spawn in between the blocks
        launch_ball()


func _physics_process(delta: float) -> void:
    var movement_vector: Vector2 = get_movement_vector()

    var collision: KinematicCollision2D = move_and_collide(movement_vector * delta) # * delta for frame rate independent movement
    if collision == null:
        return

    var collider: PhysicsBody2D = collision.get_collider()
    if not is_instance_valid(collider):
        return

    play_hit_sfx()

    if collider.name.contains(&'Ceiling'):
        # TODO: bounce from ceiling
        # TODO: paddle gets narrower
        pass
    elif collider.name.contains(&'Ground'):
        # TODO: bounce from ground
        pass
    elif collider.name.contains(&'Wall'):
        # TODO: bounce from wall
        pass
    elif collider.name.contains(&'Brick'):
        # TODO: destroy brick
        # TODO: increase ball speed
        pass
    elif collider.name.contains(&'Paddle'):
        # TODO: bounce upwards from paddle
        pass


func get_movement_vector() -> Vector2:
    var movement: Vector2 = Vector2.ZERO
    movement.x = speed * sin(angle)
    movement.y = speed * cos(angle)
    return movement


func launch_ball() -> void:
    randomize() # randomize seed
    var angle_deg: float = randf_range(toss_angle_boundary.x, toss_angle_boundary.y)
    var angle_rad: float = deg_to_rad(angle_deg)
    angle = angle_rad


func play_hit_sfx() -> void:
    sfx_audio_stream_player_2d.stream = Audio.get_ball_hit_audio()
    sfx_audio_stream_player_2d.play()
