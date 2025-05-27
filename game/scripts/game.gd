extends Node


var score: int = 0
var high_score: int = 0
var lives: int = 3
var destroyed_bricks: int = 0


@export var score_increment: int = 10
@export var max_bricks: int = 128


@onready var score_label: Label = $UI/ScoreLabel
@onready var high_score_label: Label = $UI/HighScoreLabel
@onready var lives_label: Label = $UI/LivesLabel
@onready var sfx_audio_stream_player_2d: AudioStreamPlayer2D = $SFXAudioStreamPlayer2D


const BALL: PackedScene = preload('res://ball/ball.tscn')


func _ready() -> void:
    load_config()
    spawn_ball()

    var error: Error = Events.touched_ground.connect(_on_touched_ground) as Error
    if error != OK:
        print("game::_ready: error when connecting touched_ground signal to _on_touched_ground: ", error_string(error))
    error = Events.brick_destroyed.connect(_on_brick_destroyed) as Error
    if error != OK:
        print("game::_ready: error when connecting destroyed_brick signal to _on_brick_destroyed: ", error_string(error))


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
    var ball: Node = BALL.instantiate()
    add_child(ball)


func _on_touched_ground() -> void:
    lives -= 1
    lives_label.text = str("Lives: ", lives)

    if lives < 1:
        play_loss_sfx()

        restart_game()


func _on_brick_destroyed(collider: PhysicsBody2D) -> void:
    collider.queue_free()
    destroyed_bricks += 1

    if destroyed_bricks >= max_bricks:
        play_win_sfx()

        restart_game()

    score += score_increment
    score_label.text = str("Score: ", score)


func play_sfx(sfx: AudioStreamWAV) -> void:
        sfx_audio_stream_player_2d.stream = sfx
        sfx_audio_stream_player_2d.play()


func play_loss_sfx() -> void:
        play_sfx(Audio.get_loss_sound())


func play_win_sfx() -> void:
        play_sfx(Audio.get_win_sound())


func restart_game() -> void:
        if score > high_score:
            high_score = score
        save_config()

        var error: Error = get_tree().reload_current_scene()
        if error != OK:
            print("game::_on_touched_ground: failed to reload current scene: ", error_string(error))
