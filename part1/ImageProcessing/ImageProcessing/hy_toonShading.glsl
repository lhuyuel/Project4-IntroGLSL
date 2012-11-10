varying vec2 v_Texcoords;

uniform sampler2D u_image;
uniform vec2 u_step;

const int KERNEL_WIDTH = 3; // Odd
const float offset = 3.0;
//======================================================
mat3 Sobel_H = mat3(-1, -2, -1, 0, 0, 0, 1, 2, 1);
mat3 Sobel_V = mat3(-1, 0, 1, -2, 0, 2, -1, 0, 1);
const vec3 W = vec3(0.2125, 0.7154, 0.0721);
const float quantize = 5;
const float threshhold =0.02;
//======================================================
void main(void)
{
	vec2 accum = vec2(0.0);
	for (int i = 0; i < KERNEL_WIDTH; ++i)
	{
		for (int j = 0; j < KERNEL_WIDTH; ++j)
		{
			vec2 coordh = vec2(v_Texcoords.s + ((float(i) - offset) * u_step.s), v_Texcoords.t + ((float(j) - offset) * u_step.t));
			vec2 coordv = vec2(v_Texcoords.s + ((float(j) - offset) * u_step.s), v_Texcoords.t + ((float(i) - offset) * u_step.t));
			float luminanceH = Sobel_H[i][j]*dot(texture2D(u_image, coordh).rgb, W);
			float luminanceV = Sobel_V[j][i]*dot(texture2D(u_image, coordv).rgb, W);
			accum += vec2(luminanceH, luminanceV);
		}
	}
	accum = accum / (KERNEL_WIDTH * KERNEL_WIDTH);
	float length = length(accum);

	if(length > threshhold )
	{
		gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
	}
	else
	{
		vec3 rgb = texture2D(u_image, v_Texcoords).rgb;
		rgb *= quantize;
		rgb += vec3(0.5);
		ivec3 irgb = ivec3(rgb);
		rgb = vec3(irgb) / quantize;
		gl_FragColor = vec4(rgb, 1.0);
	}
}