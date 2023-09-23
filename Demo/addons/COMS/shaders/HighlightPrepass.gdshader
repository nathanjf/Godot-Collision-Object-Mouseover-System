shader_type canvas_item;

// Use the alpha channel to mask out where objects are

void fragment() {
	COLOR.rgb = texture(TEXTURE, UV).a * vec3(0.1,0.1,0.1);
	COLOR.a = 1.0;
}
