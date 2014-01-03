---VERTEX SHADER---
#version 120
#ifdef GL_ES
    precision highp float;
#endif

/* Outputs to the fragment shader */
varying vec4 frag_color;
varying mat4 rot_mat;

/* vertex attributes */
attribute vec2     vPosition;
attribute float    vSize;
attribute float    vRotation;


/* uniform variables */
uniform mat4       modelview_mat;
uniform mat4       projection_mat;
uniform vec4       color;
uniform float      opacity;

void main (void) {
  frag_color = color * vec4(1.0, 1.0, 1.0, opacity);
  float rot = radians(vRotation);
  float a_sin = sin(rot);
  float a_cos = cos(rot);
  mat4 rot_mat = mat4(a_cos, -a_sin, 0.0, 0.0,
                    a_sin, a_cos, 0.0, 0.0,
                    0.0, 0.0, 1.0, 0.0,
                    0.0, 0.0, 0.0, 1.0 );
  vec4 pos = vec4(vPosition.xy, 0.0, 1.0);
  gl_Position = projection_mat * modelview_mat * pos;
  gl_PointSize = vSize;

}


---FRAGMENT SHADER---
#version 120
#ifdef GL_ES
    precision highp float;
#endif

/* Outputs from the vertex shader */
varying vec4 frag_color;
varying mat4 rot_mat;

/* uniform texture samplers */
uniform sampler2D texture0;

void main (void){
    vec2 tex_coord = (rot_mat * vec4(gl_PointCoord, 0, 1)).xy;
    gl_FragColor = frag_color; /* * texture2D(texture0, gl_PointCoord); */
}