shader_type canvas_item;

#define CLEAR vec4(0.0, 0.0, 0.0, 0.0)

uniform float anim_time = 1.5;
uniform float t = 1.0;
uniform sampler2D old_texture : repeat_disable;


float ease(float x) {
	return -(cos(PI * x) - 1.0) / 2.0;
}

float cubicEase(float x) {
	if (x < 0.5) {
		return 4.0 * pow(x, 3.0);
	} else {
		return 1.0 - pow(-2.0 * x + 2.0, 3) / 2.0;
	}
}

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
	if (t >= anim_time) {
		COLOR = CLEAR;
	} else {
		float new_t = t / anim_time * (rand(vec2(UV.x)) * 0.15 + 1.0);
		new_t = clamp(new_t, 0, 1);
		
		vec2 uv = UV + vec2(0, -cubicEase(new_t));
		
		if (uv.y > 0.0) {
			COLOR = texture(old_texture, uv);
		} else {
			COLOR = CLEAR;
		}
	}
}