shader_type canvas_item;

uniform float t = 0.0;
uniform sampler2D final_texture;
uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {
	COLOR = smoothstep(texture(screen_texture, SCREEN_UV), texture(final_texture, UV), vec4(t));
}
