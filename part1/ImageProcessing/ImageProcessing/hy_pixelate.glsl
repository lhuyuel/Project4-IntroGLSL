varying vec2 v_Texcoords;

uniform sampler2D u_image;

void main(void)
{
	vec2 dimensions = vec2(640, 480);
	vec2 pixel = vec2(5.0/dimensions.x, 5.0/dimensions.y);

	vec2 coord = vec2(pixel.x * floor(v_Texcoords.x/pixel.x), pixel.y * floor(v_Texcoords.y/pixel.y));
    gl_FragColor = texture2D(u_image, coord);
}