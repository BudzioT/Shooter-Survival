shader_type canvas_item;

// Uniform indicating current player shader color
uniform vec3 currentColor: source_color = vec3(1);
// Filter for the texture mix
uniform float filter: hint_range(0.0, 1.0, 0.1) = 0;


void fragment() {
	// Get alpha of a pixel
	float alpha = texture(TEXTURE, UV).a;
	
	// Mix the color, use color uniform and filter one
	vec4 result = mix(texture(TEXTURE, UV), vec4(currentColor, alpha), filter);
	// Update the color
	COLOR = result;
}
