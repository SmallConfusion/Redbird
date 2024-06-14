shader_type canvas_item;

#define H_COUNT 160.0
#define V_COUNT 144.0

uniform sampler2D pixel_overlay;


void fragment() {
	COLOR = texture(pixel_overlay, mod(UV * vec2(H_COUNT, V_COUNT), 1));
}