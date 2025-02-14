#version 460 compatibility

uniform mat4 gbufferModelViewInverse;

out vec2 texcoord;
out vec3 normal;
out vec4 glcolor;
out vec2 lmcoord;

void main() {
    normal = gl_NormalMatrix * gl_Normal;
    normal = mat3(gbufferModelViewInverse) * normal; // this converts the normal to world/player space

    gl_Position = ftransform();
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    lmcoord = (lmcoord * 33.05 / 32.0) - (1.05 / 32.0);
    glcolor = gl_Color;
}