shader_type canvas_item;

uniform sampler2D mask_texture: filter_linear;
uniform int frame_pixel_width = 1320;
uniform int frame_index: hint_range(0, 100, 1) = 0;
//uniform sampler2D noise_texture: filter_linear;
//uniform float distortion_amount = 0.03;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 new_uv;
	
	ivec2 texture_size =  textureSize(mask_texture, 0);
	new_uv = vec2(UV.x+float(frame_index) * float(frame_pixel_width) / float(texture_size.x), UV.y);
	COLOR.a = texture(mask_texture, new_uv).r;
	
	//vec2 distortion_value = (texture(noise_texture, UV + (TIME * 0.01)).rg *2.0) - 1.0 * texture(mask_texture, new_uv).r;
	//vec2 distortion = (distortion_value * distortion_amount);
	//vec4 color = texture(TEXTURE, new_uv + distortion);
	//COLOR.rgba = vec4(color.rgba);
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
