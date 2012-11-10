varying vec2 v_Texcoords;
uniform float time;
uniform sampler2D u_image;

void main(void)
{
	vec3 rgb = texture2D(u_image, v_Texcoords*0.6).rgb;
	rgb = rgb* vec3(0,1.0,0);
	gl_FragColor = vec4(rgb, 1.0);
}