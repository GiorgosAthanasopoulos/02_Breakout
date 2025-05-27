extends RigidBody2D


@export var toss_angle_boundary: Vector2 = Vector2(45, 45 + 90) # clockwise, in degrees
@export var initial_speed: float = 400
@export var speed_multiplier_percetange: float = 1.5


@onready var sfx_audio_stream_player_2d: AudioStreamPlayer2D = $SFXAudioStreamPlayer2D


var angle: float
var speed: float


func _ready() -> void:
    speed = initial_speed
    launch_ball()


func _physics_process(delta: float) -> void:
    var movement_vector: Vector2 = get_movement_vector()

    var collision: KinematicCollision2D = move_and_collide(movement_vector * delta) # * delta for frame rate independent movement
    if collision == null:
        return
    handle_collision(collision)


func handle_collision(collision: KinematicCollision2D) -> void:
    var collider: PhysicsBody2D = collision.get_collider()
    if not is_instance_valid(collider):
        return

    if collider.name.contains(&'Ceiling'):
        handle_ceiling_collision()
    elif collider.name.contains(&'Ground'):
        handle_ground_collision()
    elif collider.name.contains(&'Wall'):
        handle_wall_collision()
    elif collider.name.contains(&'Brick'):
        handle_brick_collision(collider)
    elif collider.name.contains(&'Paddle'):
        handle_paddle_collision()


func handle_ceiling_collision() -> void:
        angle = -angle
        play_hit_sfx()
        Events.touched_ceiling.emit()


func handle_ground_collision() -> void:
        angle = -angle
        play_hit_sfx()
        Events.touched_ground.emit()


func handle_wall_collision() -> void:
        angle = PI - angle
        play_hit_sfx()


func handle_brick_collision(collider: PhysicsBody2D) -> void:
    angle = -angle
    play_explosion_sfx()
    Events.brick_destroyed.emit(collider)
    @warning_ignore('integer_division')
    var increment: float = speed * (speed_multiplier_percetange / 100)
    speed += increment


func handle_paddle_collision() -> void:
        play_hit_sfx()
        angle = -angle


func get_movement_vector() -> Vector2:
    var movement: Vector2 = Vector2.ZERO
    movement.x = speed * cos(angle)
    movement.y = speed * sin(angle)
    return movement


func launch_ball() -> void:
    position = get_viewport_rect().size / 2
    position.y += 60 # so it doesnt spawn in between the blocks
    randomize() # randomize seed
    var angle_deg: float = randf_range(toss_angle_boundary.x, toss_angle_boundary.y)
    var angle_rad: float = deg_to_rad(angle_deg)
    angle = angle_rad


func play_sfx(sfx: AudioStreamWAV) -> void:
    sfx_audio_stream_player_2d.stream = sfx
    sfx_audio_stream_player_2d.play()


func play_hit_sfx() -> void:
    play_sfx(Audio.get_hit_sound())


func play_explosion_sfx() -> void:
    play_sfx(Audio.get_explosion_sound())


func play_win_sfx() -> void:
    play_sfx(Audio.get_win_sound())


func play_loss_sfx() -> void:
    play_sfx(Audio.get_loss_sound())
