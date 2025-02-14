#version 460 compatibility

out vec2 texcoord;
out vec4 color;

void main() {
    gl_Position = ftransform();
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    color = vec4(1.0);
}