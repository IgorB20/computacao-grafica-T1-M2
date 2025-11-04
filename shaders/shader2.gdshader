shader_type spatial;

// Intensidade (altura da onda) e frequência (densidade de cristas)
uniform float amplitude : hint_range(0.0, 2.0)     // Máximo deslocamento
    = 0.3;                                        // Padrão 0.3 unidades
uniform float frequency : hint_range(0.0, 10.0)    // Quantas ondas cabem na malha
    = 4.0;                                        // Padrão 4 ciclos por unidade

varying float v_displacement;                      // Leva valor de d(deslocamento) pro fragment

void vertex() {
    // Calcula deslocamento combinando duas senóides em X e Y
    float d = sin(TIME + VERTEX.x * frequency)
            * sin(TIME + VERTEX.y * frequency)
            * amplitude;
    v_displacement = d;                            // Guarda pro fragment
    VERTEX += NORMAL * d;                          // Move vértice ao longo da normal
}

void fragment() {
    // Mapeia d (em [-amplitude, +amplitude]) pra t em [0,1]
    float t = (v_displacement / amplitude) * 0.5 + 0.5;
    // Interpola entre azul e laranja conforme t
    ALBEDO = mix(vec3(0.1,0.3,0.8), vec3(0.8,0.3,0.1), t);
}