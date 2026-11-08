shader_type canvas_item;

uniform vec2 direction = vec2(1.0, 0.0);
uniform float speed = 0.1;

// Aparición
uniform float reveal_progress : hint_range(0.0, 1.0) = 1.0;
uniform vec2 reveal_direction = vec2(1.0, 1.0);

void fragment() {
    // Movimiento de textura
    vec2 offset = direction * speed * TIME;
    vec2 uv = fract(UV + offset);

    vec4 color = texture(TEXTURE, uv);

    // Máscara configurable
    vec2 dir = normalize(reveal_direction);

    float diagonal = dot(UV, dir);

    float min_value = min(0.0, dir.x) + min(0.0, dir.y);
    float max_value = max(0.0, dir.x) + max(0.0, dir.y);

    float threshold = mix(max_value, min_value, reveal_progress);

    float mask = step(threshold, diagonal);

    // Control de extremos
    if (reveal_progress <= 0.0) {
        mask = 0.0;
    } else if (reveal_progress >= 1.0) {
        mask = 1.0;
    }

    color.a *= mask;

    COLOR = color;
}