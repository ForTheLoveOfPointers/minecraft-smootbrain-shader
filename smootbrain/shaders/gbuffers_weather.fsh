#version 460 compatibility

uniform sampler2D colortex0;

in vec2 texcoord;
in vec4 color;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 outColor;

void main() {
    outColor = texture(colortex0, texcoord) * color;
}