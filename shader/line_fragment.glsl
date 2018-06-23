precision highp float;
uniform float time;
uniform vec2 resolution;
varying vec3 fPosition;
varying vec3 fNormal;

varying vec2 vUv;

uniform sampler2D texture;
uniform sampler2D inkTexture;
uniform sampler2D inkInnerTexture;

const float sigma = 1.0;
const float pi = 3.14159265;
const float _thred = 0.8;

vec2 blinnPhongDir(vec3 lightDir, float lightInt, float Ka, float Kd, float Ks, float shininess)
{
 vec3 s = normalize(lightDir);
 vec3 v = normalize(-fPosition);
 vec3 n = normalize(fNormal);
 vec3 h = normalize(v+s);
 float diffuse = Ka + Kd * lightInt * max(0.0, dot(n, s));
 float spec =  Ks * pow(max(0.0, dot(n,h)), shininess);
 
 return vec2(diffuse, spec);
}

float rim()
{
 vec3 normal = normalize(fNormal);
 vec3 eye = normalize(-fPosition);
 float rim = dot(normal, eye);
 return rim;
}

// turn a color to target color
float lerpColor(float target, float inColor, float value) {
    return inColor*value+target*(1.0-value);
}

// return max value in a vector 3
float max3(vec3 data) {
    float maxV = max(data.x, data.y);
    maxV = max(maxV, data.z);
    return maxV;
} 

vec4 blur13(sampler2D image, vec2 uv, vec2 resolution, vec2 direction) {
  vec4 color = vec4(0.0);
  vec2 off1 = vec2(1.411764705882353) * direction;
  vec2 off2 = vec2(3.2941176470588234) * direction;
  vec2 off3 = vec2(5.176470588235294) * direction;
  color += texture2D(image, uv) * 0.1964825501511404;
  color += texture2D(image, uv + (off1 / resolution)) * 0.2969069646728344;
  color += texture2D(image, uv - (off1 / resolution)) * 0.2969069646728344;
  color += texture2D(image, uv + (off2 / resolution)) * 0.09447039785044732;
  color += texture2D(image, uv - (off2 / resolution)) * 0.09447039785044732;
  color += texture2D(image, uv + (off3 / resolution)) * 0.010381362401148057;
  color += texture2D(image, uv - (off3 / resolution)) * 0.010381362401148057;
  return color;
}

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main()
{ 
 vec3 lightDir = vec3(1.0, 1.0, 1.0);
 
 vec2 ds = blinnPhongDir(lightDir, 1.0, 0.3, 0.5, 0.0, 300.0);
 
 float brightness = ds.x + ds.y;
 
 brightness = ceil(brightness * 3.0)/ 3.0;

 float rim = rim();

 /* not work on building */
 //float borderAlaph = (rim<0.15)?sqrt(rim):1.0;

 rim = clamp(sin((rim/_thred+0.15)*pi), 0.0, 1.0);

 
 //gl_FragColor = texture2D(texture, vUv) * brightness * rim();
 //vec2 findColor = vec2(rim,vUv.x/2.0+vUv.y/2.0);
 
 // outline.a = 1.0- (outline.r+outline.g+outline.b) / 3.0;
 
 //gl_FragColor = vec4(vec3(0.0), sqrt(alpah));
 //gl_FragColor = vec4(vec3(0.0), rim);


 /* outline */
 float ink = texture2D(inkTexture, fract(vUv*2.0)).r;
 float alpah = clamp(rim-ink, 0.0, 1.0);

 /* inner */
 //blur color
 vec3 originColor = blur13(texture, vUv, resolution, vec2(rand(vUv)*2.0-1.0,rand(vUv)*2.0-1.0)).xyz;//texture2D(texture, vUv).xyz;
 
 float maxV = max3(originColor);
 float lerpValue = 0.3;
 originColor.r = lerpColor(maxV, originColor.r, lerpValue);
 originColor.g = lerpColor(maxV, originColor.g, lerpValue);
 originColor.b = lerpColor(maxV, originColor.b, lerpValue);
 originColor*=1.2;
 //originColor *= vec3(0.886,0.831,0.694);
 //originColor = ceil(originColor*4.0)/4.0;
 

 vec3 inkInner = texture2D(inkInnerTexture, vUv).xyz;
 //originColor *= ink;
 originColor = 1.0-inkInner*(1.0-originColor);
 originColor *= vec3(0.886,0.831,0.694);
 vec4 color = vec4(originColor - alpah, 1.0);

 gl_FragColor = color;
 //gl_FragColor = vec4(vec3(borderAlaph), 1.0);
}