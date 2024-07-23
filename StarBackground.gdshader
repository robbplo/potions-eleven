shader_type canvas_item;
render_mode blend_mix;

uniform sampler2D noise_texture;

const float scale = 0.01;

void vertex() {

}

void fragment() {
	vec2 pos = UV/2.0 + 0.25;
	float noiseValue = texture(noise_texture, pos + vec2(cos(TIME), sin(TIME)) *scale).r;
	COLOR.a = COLOR.a - noiseValue;
}



//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
