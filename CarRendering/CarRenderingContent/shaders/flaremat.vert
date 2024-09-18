precision lowp int; 
precision lowp float;

VARYING vec2 texcoord;
VARYING vec2 smokecoord;

void MAIN()
{
    texcoord = UV0;
	smokecoord = UV0+vec2(uTime);
}