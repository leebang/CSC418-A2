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
  // Your solution should go here.
  // Only the ambient colour calculations have been provided as an example.
    
    // normalize normalInterp
    vec3 V_NORM = normalize(normalInterp);
    // light direction
    vec3 V_LIGHT = normalize(lightPos - vertPos);
    // b
    vec3 V_VIEW = normalize(-vertPos);
    // specular reflection
    vec3 V_REFL = reflect(-V_LIGHT, V_NORM);
    
    // Ambient + Diffuse + Specular
    vec3 allLight =
    (Ka * ambientColor) +
    (Kd * diffuseColor * max(0.0, dot(V_NORM, V_LIGHT))) +
    specularColor * Ks * pow(max(0.0, dot(V_REFL, V_VIEW)), shininessVal);
    
    
  gl_FragColor = vec4(allLight, 1.0);
}
