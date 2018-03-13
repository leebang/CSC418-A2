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
  
  // The model is currently rendered in black
    // normalize normalInterp
    vec3 V_NORM = normalize(normalInterp);
    // b
    vec3 V_VIEW = normalize(-vertPos);
    // Diff
    vec3 Diff = (Kd * diffuseColor * (1.0 - abs(dot(V_NORM, V_VIEW))));
    
    
  gl_FragColor = vec4(Diff, 1.0);
}
