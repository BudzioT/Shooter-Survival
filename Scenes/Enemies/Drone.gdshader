shader_type canvas_item;


// Shader color
uniform vec3 color: source_color = vec3(1);
// Shader filter
uniform float filter: hint_range(0.0, 1.0, 0.1) = 0;


void fragment() {
	// Alpha value of the pixel
	float alpha = texture(TEXTURE, UV).a;
	
	// Create a new color by mixing old one with the uniform color
	vec4 resultColor = mix(texture(TEXTURE, UV), vec4(color, alpha), filter);
	// Update the color
	COLOR = resultColor;
}