extends Node2D

@export var width := 9
@export var height := 1

@export var off : Texture2D
@export var on : Texture2D

var number := 0
var last_number := -1

var sprites = []

func _ready():
	position += Vector2(0.5, 0.5)
	
	for y in height:
		for x in width:
			var sprite = Sprite2D.new()
			sprite.texture = off
			sprite.position.x = x * 2
			sprite.position.y = y * 2
			add_child(sprite)
			
			sprites.append(sprite)


func _process(_delta):
	if last_number != number:
		last_number = number
		
		var places = range(len(sprites)-1, -1, -1)
		var i = 0
		
		for sprite in sprites:
			var compare = 2 ** places[i]
			
			if number >= compare:
				sprite.texture = on
				number -= compare
			else:
				sprite.texture = off
			
			i += 1
		
		number = last_number
