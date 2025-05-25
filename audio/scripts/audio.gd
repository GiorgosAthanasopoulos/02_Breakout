extends Node

const ball_hit: AudioStreamWAV = preload('res://assets/sounds/hit/trimmed/269718__michorvath__ping-pong-ball-hit.wav')


func get_ball_hit_audio() -> AudioStreamWAV:
    return ball_hit
