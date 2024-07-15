shader_type canvas_item;


// Uniform with current color
uniform vec3 currentColor: source_color = vec3(1);
// Progress of color changes
uniform float progress: hint_range(0.0, 1.0, 0.1) = 0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Get the current alpha value of a pixel
	float currenAlpha = texture(TEXTURE, UV).a;
	
	// Get the result color when mixing current one with pure white
	vec4 resultColor = mix(texture(TEXTURE, UV), vec4(currentColor, currenAlpha), progress);
	// Set the current color to the result one
	COLOR = resultColor;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
