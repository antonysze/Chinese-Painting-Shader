precision highp float;
uniform float time;
uniform vec2 resolution;
varying vec3 fPosition;
varying vec3 fNormal;

varying vec2 vUv;

uniform sampler2D texture;

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
 return (rim>0.65)?1.0:rim*rim;
}

void main()
{ 
 vec3 lightDir = vec3(1.0, 1.0, 1.0);
 
 vec2 ds = blinnPhongDir(lightDir, 1.0, 0.3, 0.5, 0.0, 300.0);
 
 float brightness = ds.x + ds.y;
 
 brightness = ceil(brightness * 3.0)/ 3.0;

 float rim = rim();
 
 //gl_FragColor = texture2D(texture, vUv) * brightness * rim();
 //vec2 findColor = vec2(rim,vUv.x/2.0+vUv.y/2.0);
 vec2 findColor = vUv;
 vec4 outline = texture2D(texture, findColor);
 gl_FragColor = outline;
// outline.a = 1.0- (outline.r+outline.g+outline.b) / 3.0;
 //gl_FragColor = vec4(vec3(0.0), findColor);
}