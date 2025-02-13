#version 460 core

in vec3 vaPosition;
in vec3 vaNormal;
in vec2 vaUV0;
in vec4 vaColor;
in ivec2 vaUV2;


uniform mat4 modelViewMatrix;
uniform mat4 gbufferModelViewInverse;
uniform mat4 projectionMatrix;
uniform vec3 chunkOffset;
uniform vec3 cameraPosition;
uniform mat3 normalMatrix;
uniform vec3 shadowLightPosition;

out vec2 texCoord;
out vec3 foliageColor;
out vec2 lightCoords;
out vec3 normal;
out vec3 worldShadowLightPosition;

void main() {
    gl_Position = projectionMatrix  * modelViewMatrix * vec4(vaPosition + chunkOffset, 1.0);

    worldShadowLightPosition = normalize(mat3(gbufferModelViewInverse) * shadowLightPosition);
    texCoord = vaUV0;
    foliageColor = vaColor.rgb;
    lightCoords = vaUV2 * (1.0/256.0) + (1.0/32.0);
    normal = normalMatrix * vaNormal;
}