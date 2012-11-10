varying vec2 v_Texcoords;
uniform sampler2D u_image;
float kContrast = 2.0;
void main(void)
{
	vec3 contrast = ( texture2D(u_image, v_Texcoords).rgb - 0.3 )*kContrast ;
	gl_FragColor = vec4(contrast,1.0); 
}