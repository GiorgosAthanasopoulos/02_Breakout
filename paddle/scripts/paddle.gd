extends CharacterBody2D


@export var speed: float = 500


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _process(delta: float) -> void:
    var movement: Vector2 = Vector2.ZERO

    if Input.is_action_pressed(&'move_left'):
        movement.x = -speed
    if Input.is_action_pressed(&'move_right'):
        movement.x = speed

    move_and_collide(movement * delta)

    var window_size_x: float = get_viewport_rect().size.x
    var collider_size_x: float = collision_shape_2d.shape.get_rect().size.x

    position.x = clamp(position.x, collider_size_x / 2, window_size_x - collider_size_x / 2)
