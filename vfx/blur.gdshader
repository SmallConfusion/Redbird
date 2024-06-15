shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable;
uniform float blur_amount = 0.5;

void fragment() {
	COLOR = textureLod(screen_texture, SCREEN_UV, blur_amount);
}