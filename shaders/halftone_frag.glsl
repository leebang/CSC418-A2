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

// HINT: Use the built-in variable gl_FragCoord to get the screen-space coordinates

void main() {
  // Your solution should go here.
  // Only the background color calculations have been provided as an example.
    
    // normalize normalInterp
    vec3 V_NORM = normalize(normalInterp);
    // light direction
    vec3 V_LIGHT = normalize(lightPos - vertPos);
    // ambient
    vec3 amb = Ka * ambientColor;
    // diffuse
    vec3 diff = Kd * diffuseColor;
    
    vec2 coor = vec2(gl_FragCoord.xy/600.0);
    float density = 60.0;
    float interval = length((coor*density - floor(coor*density))*2.0 - 1.1);
    float rad = 1.0 - max(0.0, dot(normalInterp, V_LIGHT));
    
    float f = step(rad, interval);
    vec3 all = mix(amb, diff, f);
  gl_FragColor = vec4(all, 1.0);
}
