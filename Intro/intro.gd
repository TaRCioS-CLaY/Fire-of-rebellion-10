extends Control

var etapas = [
	preload("res://Intro/PrimeiraParte.tscn"),
	preload("res://Intro/SegundaParte.tscn"),
	preload("res://Intro/TerceiraParte.tscn"),
	preload("res://Intro/QuartaParte.tscn")
]

var etapa = 0
var endText = false
var current
var next

func _ready():
	next = etapas[etapa].instance()
	add_child(next)
	_connect_tween()

func _connect_tween():
	var tween = next.find_node("Tween")
	tween.connect("tween_all_completed", self, "_enable_next")

func _process(delta):
	if endText:
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_select"):
			if etapa > 3:
				print_debug("começa jojo")
				return
			remove_child(current)
			next = etapas[etapa].instance()
			add_child(next)
			_connect_tween()

func _enable_next():
	etapa = etapa + 1
	endText = true
	current  = next
