shader_type canvas_item;

uniform sampler2D viewport;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	vec3 color = texture(screen_texture, UV).rgb;
	vec3 viewport_color = texture(viewport, UV).rgb;
	
	vec3 diff = viewport_color - color;
	
	diff.r *= sign(diff.r) / 8.0 + 0.65;
	diff.g *= sign(diff.g) / 8.0 + 0.65;
	diff.b *= sign(diff.b) / 8.0 + 0.65;
	
	color += diff;
	
	COLOR.rgb = color;
}
