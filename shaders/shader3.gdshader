shader_type spatial;

uniform float stripe_width : hint_range(0.1, 2.0)     // Largura de cada listra
    = 0.5;                                           // Valor padrão 0.5 unidades
uniform float scroll_speed : hint_range(-1.0, 1.0)    // Quao rapido as listras deslizam
    = 0.2;                                           // Padrão 0.2 (positivo anda pra +X, negativo pra -X)
uniform vec3  color_even   = vec3(0.1, 0.1, 0.1);     // Cor das listras “pares”
uniform vec3  color_odd    = vec3(1.0, 0.8, 0.2);     // Cor das listras “ímpares”

varying vec3 v_local_pos;                             // Vai levar a pos. local do vértice pro fragment

void vertex() {
    v_local_pos = VERTEX;                            // Salva posição local atual do vértice
}

void fragment() {
    float u = v_local_pos.x + TIME * scroll_speed;   // Posição X + tempo*velocidade
    float f = fract(u / stripe_width);               // Normaliza ciclando [0,1) por largura
    float stripe = step(0.5, f);                     // Se f>=0.5 → 1, senão 0 (par/ímpar)

    ALBEDO    = mix(color_even, color_odd, stripe);  // Escolhe cor com base em stripe
    METALLIC  = stripe;                              // Ímpar é metálico, par não
    ROUGHNESS = 1.0 - stripe * 0.8;                  // Par é fosco total, ímpar um pouco brilhante
    EMISSION  = color_odd * stripe * 0.2;            // Ímpar emite 20% da sua cor
}