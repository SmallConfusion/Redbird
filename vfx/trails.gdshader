shader_type canvas_item;

uniform sampler2D viewport;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	vec3 viewport_color = texture(viewport, UV).rgb;
	vec3 screen_color = texture(screen_texture, UV).rgb;
	
	vec3 diff = viewport_color.rgb - screen_color.rgb;
	
	const float bright_mul = 0.8;
	const float dark_mul = 0.5;
	
	screen_color.r += max(diff.r, 0) * bright_mul + min(diff.r, 0) * dark_mul;
	screen_color.g += max(diff.g, 0) * bright_mul + min(diff.g, 0) * dark_mul;
	screen_color.b += max(diff.b, 0) * bright_mul + min(diff.b, 0) * dark_mul;
	
	COLOR.rgb = screen_color.rgb;
}
