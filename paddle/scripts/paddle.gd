extends CharacterBody2D


@export var speed: float = 550
@export var size_decrement_step_percent: float = 5
@export var minimum_scale: Vector2 = Vector2(0.1, 0.1)
# AI
@export var ai: bool = false
@export var ai_perfect: bool = true
@export var reaction_delay: float = 0.1  # seconds
@export var tracking_error: int = 20   # pixels of imprecision
@export var decision_timer:float  = 0.0
@export var target_x: float = 0.0


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
    var error: Error = Events.touched_ceiling.connect(_on_touched_ceiling) as Error
    if error != OK:
        print("paddle::_ready: error when connecting touched_ceiling signal to _on_touched_ceiling: ", error_string(error))


func _process(delta: float) -> void:
    var movement_vector: Vector2 = get_movement_vector() if not ai else get_ai_movement_vector(delta)
    var __: KinematicCollision2D = move_and_collide(movement_vector * delta)

    var window_size_x: float = get_viewport_rect().size.x
    var collider_size_x: float = collision_shape_2d.shape.get_rect().size.x
    position.x = clamp(position.x, collider_size_x / 2, window_size_x - collider_size_x / 2)


func get_movement_vector() -> Vector2:
    var movement: Vector2 = Vector2.ZERO

    if Input.is_action_pressed(&'move_left'):
        movement.x = -speed
    if Input.is_action_pressed(&'move_right'):
        movement.x = speed

    return movement


func get_ai_movement_vector(delta: float) -> Vector2:
    var movement_vector: Vector2 = Vector2.ZERO
    var ball: Node = get_node("/root/Game/Ball")
    if ball == null:
        print("paddle::get_ai_movement_vector: could not find ball node in scene")
        return movement_vector

    if ai_perfect:
        @warning_ignore('unsafe_property_access')
        var ball_position: Vector2 = ball.global_position
        position.x = ball_position.x

    else:
        decision_timer -= delta

        if decision_timer <= 0:
            # Time to re-evaluate the target
            @warning_ignore('unsafe_property_access')
            target_x = ball.global_position.x + randf_range(-tracking_error, tracking_error)
            decision_timer = reaction_delay + randf_range(0.0, 0.05)  # add variability

        # Move towards the target y, but clamp to paddle speed
        var direction: float = sign(target_x - position.x)
        position.x += direction * speed * delta

    return movement_vector


func _on_touched_ceiling() -> void:
    if scale > minimum_scale:
        scale -= scale * (size_decrement_step_percent / 100)
