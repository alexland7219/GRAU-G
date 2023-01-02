#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

uniform mat4 modelViewProjectionMatrix;
uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;
uniform float time;
in vec4 vfrontColor[];
out vec4 gfrontColor;

void draw_tetrabrick(vec3 lo, vec3 hi){
	// FRONT FACE
	gfrontColor = vec4(0,0,1,1);
	gl_Position = modelViewProjectionMatrix * vec4(hi, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(lo.x, hi.y, hi.z, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(hi.x, lo.y, hi.z, 1.0);
	EmitVertex();
	EndPrimitive();

	gl_Position = modelViewProjectionMatrix * vec4(lo.x, lo.y, hi.z, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(lo.x, hi.y, hi.z, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(hi.x, lo.y, hi.z, 1.0);
	EmitVertex();
	EndPrimitive();

	// BACK FACE
	gfrontColor = vec4(0,0,1,1);
	gl_Position = modelViewProjectionMatrix * vec4(hi.x, hi.y, lo.z, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(lo.x, hi.y, lo.z, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(hi.x, lo.y, lo.z, 1.0);
	EmitVertex();
	EndPrimitive();

	gl_Position = modelViewProjectionMatrix * vec4(lo, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(lo.x, hi.y, lo.z, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(hi.x, lo.y, lo.z, 1.0);
	EmitVertex();
	EndPrimitive();

	// TOP
	gfrontColor = vec4(0,1,0,1);
	gl_Position = modelViewProjectionMatrix * vec4(hi, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(lo.x, hi.y, hi.z, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(lo.x, hi.y, lo.z, 1.0);
	EmitVertex();
	EndPrimitive();

	gl_Position = modelViewProjectionMatrix * vec4(hi, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(lo.x, hi.y, lo.z, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(hi.x, hi.y, lo.z, 1.0);
	EmitVertex();
	EndPrimitive();

	// BOTTOM
	gfrontColor = vec4(0,1,0,1);
	gl_Position = modelViewProjectionMatrix * vec4(hi.x, lo.y, hi.z, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(lo.x, lo.y, hi.z, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(lo.x, lo.y, lo.z, 1.0);
	EmitVertex();
	EndPrimitive();

	gl_Position = modelViewProjectionMatrix * vec4(hi.x, lo.y, hi.z, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(lo.x, lo.y, lo.z, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(hi.x, lo.y, lo.z, 1.0);
	EmitVertex();
	EndPrimitive();

	// LEFT
	gfrontColor = vec4(1,0,0,1);
	gl_Position = modelViewProjectionMatrix * vec4(lo, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(lo.x, hi.y, lo.z, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(lo.x, lo.y, hi.z, 1.0);
	EmitVertex();
	EndPrimitive();
	
	gl_Position = modelViewProjectionMatrix * vec4(lo.x, hi.y, hi.z, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(lo.x, hi.y, lo.z, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(lo.x, lo.y, hi.z, 1.0);
	EmitVertex();
	EndPrimitive();

	// RIGHT
	gfrontColor = vec4(1,0,0,1);
	gl_Position = modelViewProjectionMatrix * vec4(hi, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(hi.x, lo.y, lo.z, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(hi.x, hi.y, lo.z, 1.0);
	EmitVertex();
	EndPrimitive();
	
	gl_Position = modelViewProjectionMatrix * vec4(hi.x, hi.y, hi.z, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(hi.x, lo.y, lo.z, 1.0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(hi.x, lo.y, hi.z, 1.0);
	EmitVertex();
	EndPrimitive();

}


void main( void )
{
	if (gl_PrimitiveIDIn == 0){
		float x_min = mix(boundingBoxMin.x, boundingBoxMax.x, fract(time));
		float x_max = x_min + 0.1;
		draw_tetrabrick(vec3(x_min, boundingBoxMin.y, boundingBoxMin.z), vec3(x_max, boundingBoxMax.y, boundingBoxMax.z));
	}

	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		gl_Position = gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();

}
