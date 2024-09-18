precision lowp int; 
precision lowp float;

VARYING vec2 texcoord;
VARYING vec2 smokecoord;

float opacity = 1.0;
float fresnel = 1.0;
float mask = 1.0;

void MAIN()
{
    fresnel = pow(abs(dot(VIEW_VECTOR,VAR_WORLD_NORMAL)),1.0);
    opacity = abs(dot(texture(tex, texcoord).rgb,abs(VAR_WORLD_NORMAL)));
    mask = smoothstep(abs(dot(texture(smoke, smokecoord).rgb,abs(VAR_WORLD_NORMAL))),0.0,0.5);
	
} 

void POST_PROCESS()
{
     COLOR_SUM = vec4(8.0,8.0,9.0,(fresnel+opacity+mask)*.05)*fresnel*opacity*mask;
}
