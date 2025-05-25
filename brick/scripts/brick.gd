extends Node


@export var color_default: Color = Color8(255, 255, 255) # white
@export var color_1: Color = Color8(255, 0, 0) # red
@export var color_2: Color = Color8(255, 140, 0) # orange
@export var color_3: Color = Color8(255, 255, 0) # yellow
@export var color_4: Color = Color8(0, 255, 0) # green
@export var color_5: Color = Color8(0, 255, 255) # cyan
@export var color_6: Color = Color8(0, 0, 255) # blue
@export var color_7: Color = Color8(75, 0, 130) # indigo
@export var color_8: Color = Color8(148, 0, 211) # violet

@export var row: int = 1


@onready var color_rect: ColorRect = $ColorRect


func _ready() -> void:
    if row == 1:
        color_rect.color = color_1
    elif row == 2:
        color_rect.color = color_2
    elif row == 3:
        color_rect.color = color_3
    elif row == 4:
        color_rect.color = color_4
    elif row == 5:
        color_rect.color = color_5
    elif row == 6:
        color_rect.color = color_6
    elif row == 7:
        color_rect.color = color_7
    elif row == 8:
        color_rect.color = color_8
    else:
        color_rect.color = color_default
