shader_type canvas_item;

uniform int kernel_size = 5;
uniform sampler2D preprocViewport;
uniform sampler2D unmodViewport;
uniform vec4 color : source_color;

// Blur the prepass image using a simple mean blur
// Subtract the prepass to get a soft gradient that starts at the edge of the object and grows outward
// Clamp the intensity to the range of [0,1]
// Multiply and add by the fraction of the highlight intensity

void fragment() {
	vec3 value = vec3(0,0,0);
	for(int i = -kernel_size/2; i <= kernel_size/2; i++ ) {
		for(int j = -kernel_size/2; j <= kernel_size/2; j++) {
			value += texture(preprocViewport, UV + vec2(float(i),float(j)) * SCREEN_PIXEL_SIZE).rgb / float(kernel_size * kernel_size);
		}
	}
	vec3 mask = value - texture(preprocViewport, UV).rgb;
	vec3 intensity = clamp(mask, vec3(0.0,0.0,0.0), vec3(1.0,1.0,1.0));
	COLOR.rgb = intensity * color.rgb + texture(unmodViewport, UV).rgb * (1.0 - intensity);	
}
