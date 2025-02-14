#version 460 compatibility

uniform sampler2D colortex0;
uniform sampler2D lightmap;
in vec2 texcoord;
in vec4 glcolor;
in vec2 lmcoord;
in vec3 normal;

/* RENDERTARGETS: 0,1,2 */
layout(location = 0) out vec4 color;
layout(location = 1) out vec4 lightmapData;
layout(location = 2) out vec4 encodedNormal;


void main() {
    color = glcolor * texture(colortex0, texcoord) * texture(lightmap, lmcoord);
    lightmapData = vec4(lmcoord, 0.0, 1.0);
    encodedNormal = vec4(normal * 0.5 + 0.5, 1.0);
    if(color.a < 0.1) {
        discard;
    }
}