shader_type canvas_item;

#define CLEAR_R 0.184
#define CLEAR_G 0.125
#define CLEAR_B 0.255

uniform sampler2D viewport;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	vec4 color = texture(screen_texture, UV);
	vec4 viewport_color = texture(viewport, UV);
	
	color *= vec4(0.65, 0.65, 0.65, 1);
	
	color.r = max(CLEAR_R, color.r);
	color.g = max(CLEAR_G, color.g);
	color.b = max(CLEAR_B, color.b);
	
	if (viewport_color != vec4(0, 0, 0, 1)) {
		color = viewport_color;
	}
	
	COLOR = color;
}
