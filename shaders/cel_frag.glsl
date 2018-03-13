precision mediump float; // It is required to set a floating point precision in all fragment shaders.

// Interpolated values from vertex shader
varying vec3 normalInterp; // Normal
varying vec3 vertPos; // Vertex position
varying vec3 viewVec; // Interpolated view vector

// uniform values remain the same across the scene
uniform float Ka;   // Ambient reflection coefficient
uniform float Kd;   // Diffuse reflection coefficient
uniform float Ks;   // Specular reflection coefficient
uniform float shininessVal; // Shininess

// Material color
uniform vec3 ambientColor;
uniform vec3 diffuseColor;
uniform vec3 specularColor;

uniform vec3 lightPos; // Light position in camera space

void main() {
  // Your solution should go here
  // Only the ambient colour calculations have been provided as an example.

    // normalize normalInterp
    vec3 V_NORM = normalize(normalInterp);
    // light direction
    vec3 V_LIGHT = normalize(lightPos - vertPos);
    // b
    vec3 V_VIEW = normalize(-vertPos);
    // specular reflection
    vec3 V_REFL = reflect(-V_LIGHT, V_NORM);
    
    // ambient
    vec3 amb = Ka * ambientColor;
    
    // Diffuse
    // 4 different levels of d_density
    float d_density = max(0.0, dot(V_NORM, V_LIGHT));
    if (d_density > 0.8) {
        d_density = 1.0;
    } else if (d_density > 0.5) {
        d_density = 0.8;
    } else if (d_density > 0.2) {
        d_density = 0.5;
    } else{
        d_density = 0.0;
    }
    vec3 diff = Kd * diffuseColor * d_density;
    
    // Specular
    float s_density = max(0.0, dot(V_REFL, V_VIEW));
    // Same rule, shapen highlight
    if (s_density > 0.98) {
        s_density = 1.0;
    } else{
        s_density = 0.0;
    }
    
    vec3 spec = Ks * specularColor * pow(s_density, shininessVal);
    
    // Ambient + Diffuse + Specular
    vec3 allLight =
    amb +
    diff +
    spec;
    
  gl_FragColor = vec4(allLight, 1.0);
}

// Reference
// http://www.lighthouse3d.com/tutorials/glsl-12-tutorial/toon-shader-version-ii/
