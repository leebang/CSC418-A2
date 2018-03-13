attribute vec3 position; // Given vertex position in object space
attribute vec3 normal; // Given vertex normal in object space
attribute vec3 worldPosition; // Given vertex position in world space

uniform mat4 projection, modelview, normalMat; // Given scene transformation matrices
uniform vec3 eyePos;	// Given position of the camera/eye/viewer

// These will be given to the fragment shader and interpolated automatically
varying vec3 normalInterp; // Normal
varying vec3 vertPos; // Vertex position
varying vec3 viewVec; // Vector from the eye to the vertex
varying vec4 color;

uniform float Ka;   // Ambient reflection coefficient
uniform float Kd;   // Diffuse reflection coefficient
uniform float Ks;   // Specular reflection coefficient
uniform float shininessVal; // Shininess

// Material color
uniform vec3 ambientColor;
uniform vec3 diffuseColor;
uniform vec3 specularColor;
uniform vec3 lightPos; // Light position in camera space


void main(){
  // Your solution should go here.
  // Only the ambient colour calculations have been provided as an example.

  vec4 vertPos4 = modelview * vec4(position, 1.0);
  gl_Position = projection * vertPos4;
    
    vec3 V_NORM = normalize(mat3(normalMat) * normal);
    // light direction
    vec3 V_LIGHT = normalize(lightPos - vec3(vertPos4));
    // b
    vec3 V_VIEW = normalize(eyePos - vec3(vertPos4));
    // specular reflection
    vec3 V_REFL = reflect(-V_LIGHT, V_NORM);

    // Ambient + Diffuse + Specular
    vec3 allLight =
    (Ka * ambientColor) +
    (Kd * diffuseColor * max(0.0, dot(V_NORM, V_LIGHT))) +
    specularColor * Ks * pow(max(0.0, dot(V_REFL, V_VIEW)), shininessVal);
    
    color = vec4(allLight, 1.0);
}
