extends Node


var score: int = 0
var high_score: int = 0
var lives: int = 3


@onready var score_label: Label = $UI/ScoreLabel
@onready var high_score_label: Label = $UI/HighScoreLabel
@onready var lives_label: Label = $UI/LivesLabel


const BALL: PackedScene = preload('res://ball/ball.tscn')


func _ready() -> void:
    load_config()
    spawn_ball()


func load_config() -> void:
    var config: Config.CConfig = Config.load_config()
    if config != null:
        high_score = config.high_score
    high_score_label.text = str("High Score: ", high_score)


func _exit_tree() -> void:
    save_config()


func save_config() -> void:
    var config: Config.CConfig = Config.CConfig.new()
    config.high_score = high_score
    Config.save_config(config)


func spawn_ball() -> void:
    @warning_ignore('unsafe_method_access')
    var ball: Node = BALL.instantiate()
    add_child(ball)
    var window_size: Vector2 = DisplayServer.window_get_size()
    @warning_ignore('unsafe_property_access')
    ball.global_position = Vector2(window_size.x/2, window_size.y/2+60)
    #ball.connect("signal_name", function)
    #ball.name = "Ball" # only need if we want paddle to access node for ai
