shader_type canvas_item;

uniform float blur_strenght: hint_range(0.0, 5) = 0.0;
uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap;

void fragment(){
	vec4 color = texture(screen_texture, SCREEN_UV, blur_strenght);
	COLOR = color;
}
