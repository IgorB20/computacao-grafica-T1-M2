shader_type spatial;

uniform sampler2D noise;
uniform float intensity : hint_range(0.0, 2.0) = 0.3;
uniform float scale : hint_range(0.1, 5.0) = 1.0;

void vertex() {
	// Called for every vertex the material is visible on.
	  // converte posição em coordenadas 0–1 pra ler o ruído
    vec2 uv = VERTEX.xz * scale * 0.5 + 0.5;

    // lê o ruído
    float n = texture(noise, uv).r;

    // desloca o vértice conforme o valor do ruído
    VERTEX += NORMAL * (n - 0.5) * intensity;
}

void fragment() {
	// Called for every pixel the material is visible on.

}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
