shader_type canvas_item;


// Uniform with shader color
uniform vec3 color: source_color = vec3(1);
// Uniform with shader filter
uniform float filter: hint_range(0.0, 1.0, 0.1) = 0;


void fragment() {
	// Get alpha of the pixel
	float opacity = texture(TEXTURE, UV).a;
	
	// Mix the color with uniform one, apply the uniform filter
	vec4 resultColor = mix(texture(TEXTURE, UV), vec4(color, opacity), filter);
	// Update the current pixel's color
	COLOR = resultColor;
}