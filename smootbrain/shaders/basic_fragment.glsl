#version 460
uniform sampler2D gtexture;
uniform float darknessFactor;
uniform sampler2D lightmap;
uniform mat4 gbufferModelViewInverse;

layout(location  =0) out vec4 fragColor;
in vec2 texCoord;
in vec3 foliageColor;
in vec2 lightCoords;
in vec3 normal;
in vec3 worldShadowLightPosition;

void main() {
    float ambient = 0.5;
    vec3 worldGeoNormal = mat3(gbufferModelViewInverse) * normal;
    vec3 worldShadowLightDirection = normalize(worldShadowLightPosition);
    float lightIntensity = clamp(dot(worldShadowLightDirection, worldGeoNormal), 0.0, 1.0);

    vec3 lightText = pow(texture(lightmap, lightCoords).rgb, vec3(2.0));
    vec4 outputColorData = pow(texture(gtexture, texCoord), vec4(2.0));
    float transparency = outputColorData.a;
    if(transparency < 0.1) {
        discard;
    }
    float darknessCoeff = 1.0 -darknessFactor;
    vec3 outputColor;
    if(lightIntensity > 0.1) {
        outputColor =  (lightIntensity + ambient) * darknessCoeff * lightText * outputColorData.rgb * pow(foliageColor, vec3(2.0));
    } else {
        outputColor =  (ambient + 0.1) * darknessCoeff * lightText * outputColorData.rgb * pow(foliageColor, vec3(2.0));
    }
    fragColor = pow(vec4(outputColor, transparency), vec4(1/2.0));
}