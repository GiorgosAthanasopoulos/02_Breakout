extends Node


@export var row_color_map: Dictionary[int, Color] = {
    0: Color8(255, 255, 255), # white
    1: Color8(255, 0, 0), # red
    2: Color8(255, 140, 0), # orange
    3: Color8(255, 255, 0), # yellow
    4: Color8(0, 255, 0), # green
    5: Color8(0, 255, 255), # cyan
    6: Color8(0, 0, 255), # blue
    7: Color8(75, 0, 130), # indigo
    8: Color8(148, 0, 211), # violet
}
@export var row: int = 1


@onready var color_rect: ColorRect = $ColorRect


func _ready() -> void:
    color_rect.color = row_color_map[row if row >= 1 and row <= 8 else 0]
