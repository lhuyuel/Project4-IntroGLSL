varying vec2 v_Texcoords;

uniform sampler2D u_image;

void main(void)
{
	vec3 rgb = texture2D(u_image, v_Texcoords).rgb;
	float u = (rgb.r + rgb.g + rgb.b)/3;
	gl_FragColor = vec4( vec3(u*rgb), 1.0 );
}