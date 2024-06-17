shader_type canvas_item;

uniform float t = 0.0;
uniform sampler2D final_texture;
uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {
	COLOR = texture(final_texture, SCREEN_UV);
}
