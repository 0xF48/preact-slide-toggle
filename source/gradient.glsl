precision lowp float;
uniform float iTime;
uniform	vec3 seed;
uniform float fade;
uniform float speed;
varying vec2 v_uv;
void main() {
	float t = iTime * speed / 3e3;
	vec3 c = vec3(0.613-cos(seed.x+t+v_uv.y+v_uv.x)*0.32,0.713-sin(seed.y+t+v_uv.y+v_uv.x)*0.305,0.65+sin(seed.z+t+v_uv.y+v_uv.x)*0.31);
	c += fade*v_uv.y;
	gl_FragColor = vec4(c,1.0);
}