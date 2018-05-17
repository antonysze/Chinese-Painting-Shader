uniform sampler2D depthTexture;
uniform sampler2D normalTexture;
uniform sampler2D inkTexture;
uniform sampler2D texture;
uniform vec2 resolution;


varying vec2 vUv;

float planeDistance(const in vec3 positionA, const in vec3 normalA, 
                    const in vec3 positionB, const in vec3 normalB) {
  vec3 positionDelta = positionB-positionA;
  float planeDistanceDelta = max(abs(dot(positionDelta, normalA)), abs(dot(positionDelta, normalB)));
  return planeDistanceDelta;
}

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main() {
    float depthCenter = texture2D(depthTexture, vUv).r;

    float px = 2.5/resolution.x;

    float Gdx = texture2D(depthTexture, vec2(vUv.s + px, vUv.t - px)).r +
        texture2D(depthTexture, vec2(vUv.s + px, vUv.t)).r * 2.0 +
        texture2D(depthTexture, vec2(vUv.s + px, vUv.t - px)).r -
        texture2D(depthTexture, vec2(vUv.s - px, vUv.t - px)).r -
        texture2D(depthTexture, vec2(vUv.s - px, vUv.t)).r * 2.0 -
        texture2D(depthTexture, vec2(vUv.s - px, vUv.t - px)).r;
    float Gdy = texture2D(depthTexture, vec2(vUv.s - px, vUv.t - px)).r +
        texture2D(depthTexture, vec2(vUv.s, vUv.t - px)).r * 2.0 +
        texture2D(depthTexture, vec2(vUv.s + px, vUv.t - px)).r -
        texture2D(depthTexture, vec2(vUv.s - px, vUv.t + px)).r -
        texture2D(depthTexture, vec2(vUv.s, vUv.t + px)).r * 2.0 -
        texture2D(depthTexture, vec2(vUv.s + px, vUv.t + px)).r;

    float Gnx = texture2D(normalTexture, vec2(vUv.s + px, vUv.t - px)).r +
        texture2D(normalTexture, vec2(vUv.s + px, vUv.t)).r * 2.0 +
        texture2D(normalTexture, vec2(vUv.s + px, vUv.t - px)).r -
        texture2D(normalTexture, vec2(vUv.s - px, vUv.t - px)).r -
        texture2D(normalTexture, vec2(vUv.s - px, vUv.t)).r * 2.0 -
        texture2D(normalTexture, vec2(vUv.s - px, vUv.t - px)).r;
    float Gny = texture2D(normalTexture, vec2(vUv.s - px, vUv.t - px)).r +
        texture2D(normalTexture, vec2(vUv.s, vUv.t - px)).r * 2.0 +
        texture2D(normalTexture, vec2(vUv.s + px, vUv.t - px)).r -
        texture2D(normalTexture, vec2(vUv.s - px, vUv.t + px)).r -
        texture2D(normalTexture, vec2(vUv.s, vUv.t + px)).r * 2.0 -
        texture2D(normalTexture, vec2(vUv.s + px, vUv.t + px)).r;
    
    float Gd = abs(Gdx) + abs(Gdy);
    float Gn = abs(Gnx) + abs(Gny);
    float G = Gd*0.7 + Gn*0.3;
    //G = Gd;
    //vec3 leftpos = vec3(vUv.s - px, vUv.t, 1.0 - texture2D(depthTexture, vec2(vUv.s - px, vUv.t)).r);
    //vec3 rightpos = vec3(vUv.s + px, vUv.t, 1.0 - texture2D(depthTexture, vec2(vUv.s + px, vUv.t)).r);
    //vec3 uppos = vec3(vUv.s, vUv.t - px, 1.0 - texture2D(depthTexture, vec2(vUv.s, vUv.t - px)).r);
    //vec3 downpos = vec3(vUv.s, vUv.t + px, 1.0 - texture2D(depthTexture, vec2(vUv.s, vUv.t + px)).r);
    //vec3 leftnor = texture2D(normalTexture, vec2(vUv.s - px, vUv.t)).xyz;
    //vec3 rightnor = texture2D(normalTexture, vec2(vUv.s + px, vUv.t)).xyz;
    //vec3 upnor = texture2D(normalTexture, vec2(vUv.s, vUv.t - px)).xyz;
    //vec3 downnor = texture2D(normalTexture, vec2(vUv.s, vUv.t + px)).xyz;
    /*
    vec2 planeDist = vec2(
        planeDistance(leftpos, leftnor, rightpos, rightnor),
        planeDistance(uppos, upnor, downpos, downnor));

    float planeEdge = 2.5 * length(planeDist);
    planeEdge = 1.0 - smoothstep(0.0, depthCenter, planeEdge);

    float normEdge = max(length(leftnor - rightnor), length(upnor - downnor));
    normEdge = 1.0 - normEdge; 
    */
    //float edge = 1.0 - (G<0.3?0.0:G);
    //G = pow(G, 30.0);

    float ink = texture2D(inkTexture, fract(vUv*1.0)).r;

    float edge = clamp(1.0 - G * ink,0.0,1.0);
    vec3 color = texture2D(texture, vUv).xyz;
    //color = floor(color*4.0)/4.0;
    
    //edge = pow(edge,2.0);
    gl_FragColor = vec4(vec3(edge)*color , 1.0);
    //texture2D(texture, vUv)
    //gl_FragColor = texture2D(texture, vUv);
}