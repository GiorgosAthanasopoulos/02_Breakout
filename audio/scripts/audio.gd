extends Node

const hit: AudioStreamWAV = preload('res://assets/sounds/hit/trimmed/269718__michorvath__ping-pong-ball-hit.wav')
const win: AudioStreamWAV = preload('res://assets/sounds/win/trimmed/668436__david819__win.wav')
const loss: AudioStreamWAV = preload('res://assets/sounds/loss/source/350982__cabled_mess__lose_c_06.wav')
const explosion: AudioStreamWAV = preload('res://assets/sounds/explosion/trimmed/621001__samsterbirdies__cannon-explosion-sound-2.wav')

func get_hit_sound() -> AudioStreamWAV:
    return hit


func get_win_sound() -> AudioStreamWAV:
    return win


func get_loss_sound() -> AudioStreamWAV:
    return loss


func get_explosion_sound() -> AudioStreamWAV:
    return explosion
