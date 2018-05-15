---


---

<p><img src="https://lh3.googleusercontent.com/u_6Wx_Ebtp34lBk2PIHO_zGgQAE9GMxJU8_ANIhv_bvSNVcsS6T8r4oO0-_K5-IhaeVI7RsBiuU" alt="enter image description here"></p>
<h3 id="shader-reference">Shader Reference</h3>
<ol>
<li><a href="https://so.csdn.net/so/search/s.do?q=%E6%B0%B4%E5%A2%A8%E7%95%AB+shader&amp;t=blog&amp;o=&amp;s=&amp;l=">水墨畫search</a></li>
<li><a href="https://blog.csdn.net/nannan0811666/article/details/79452197">水墨畫 shader</a></li>
<li><a href="https://blog.csdn.net/u011712406/article/details/50085281">WebGL+shader实现素描效果渲染</a></li>
<li><a href="https://blog.csdn.net/wolf96/article/details/43670851">unity3d shader之Roberts,Sobel,Canny 三种边缘检测方法</a></li>
<li><a href="https://zhuanlan.zhihu.com/p/25339585">在Unity中如何进行水墨风3D渲染 (雞)</a></li>
<li><a href="https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&amp;arnumber=6643655">Accelerating Harris Algorithm with GPU for Corner Detection</a></li>
<li><a href="https://www.youtube.com/watch?v=7en8Y0GM55I">Ink Brush tutorial 水墨特效教學(Unity+3dsmax+After Effect)</a></li>
<li><a href="https://realtimevfx.com">Real Time VFX</a></li>
<li><a href="http://flafla2.github.io/2014/08/09/perlinnoise.html">Perlin Noise</a></li>
</ol>
<h3 id="paper">Paper</h3>
<ol>
<li><strong>Cornell university</strong>
<ol>
<li><a href="https://github.com/jcjohnson/neural-style">A Neural Algorithm of Artistic Style</a></li>
<li><a href="https://github.com/manuelruder/artistic-videos">Artistic style transfer for videos (implementation of neural-style)</a></li>
<li><a href="https://github.com/manuelruder/artistic-videos">Artistic style transfer for videos and spherical images (faster then above)</a></li>
</ol>
</li>
</ol>
<h3 id="photoshop-reference">Photoshop Reference</h3>
<p><a href="https://design.tutsplus.com/tutorials/how-to-create-a-traditional-chinese-ink-painting-based-on-a-scenic-photo--psd-4807">How to Create a Traditional, Chinese Ink Painting Based on a Scenic Photo</a></p>
<h3 id="other-reference">Other Reference</h3>
<p><a href="http://www.cse.psu.edu/~rtc12/CSE486/">Computer Vision I (Penn State University)</a><br>
<a href="http://blog.sina.com.cn/s/blog_471132920101dayr.html">Unity3D教程宝典之Shader篇：特别讲 CG函数</a></p>
<h3 id="tools">Tools</h3>
<ol>
<li><a href="https://www.desmos.com/calculator">Desmos | Graphing Calculator</a></li>
</ol>
<h3 id="ideas">ideas</h3>
<ul>
<li class="task-list-item"><input type="checkbox" class="task-list-item-checkbox" disabled=""> Check the normal around the original point by <strong>Sobel Edge Detection</strong><a href="#shader-reference">^4</a>, the alpha be lower if the normal are very different</li>
</ul>
<h3 id="exercise-5">Exercise 5</h3>
<pre class=" language-glsl"><code class="prism  language-glsl"><span class="token keyword">precision</span> <span class="token keyword">highp</span> <span class="token keyword">float</span><span class="token punctuation">;</span>
<span class="token keyword">uniform</span> <span class="token keyword">float</span> time<span class="token punctuation">;</span>
<span class="token keyword">uniform</span> <span class="token keyword">vec2</span> resolution<span class="token punctuation">;</span>
<span class="token keyword">varying</span> <span class="token keyword">vec3</span> fPosition<span class="token punctuation">;</span>
<span class="token keyword">varying</span> <span class="token keyword">vec3</span> fNormal<span class="token punctuation">;</span>
<span class="token keyword">varying</span> <span class="token keyword">vec3</span> fDepth<span class="token punctuation">;</span>

<span class="token keyword">vec2</span> <span class="token function">blinnPhongDir</span><span class="token punctuation">(</span><span class="token keyword">vec3</span> lightDir<span class="token punctuation">,</span> <span class="token keyword">float</span> lightInt<span class="token punctuation">,</span> <span class="token keyword">float</span> Ka<span class="token punctuation">,</span> <span class="token keyword">float</span> Kd<span class="token punctuation">,</span> <span class="token keyword">float</span> Ks<span class="token punctuation">,</span> <span class="token keyword">float</span> shininess<span class="token punctuation">)</span>
<span class="token punctuation">{</span>
 <span class="token keyword">vec3</span> s <span class="token operator">=</span> <span class="token function">normalize</span><span class="token punctuation">(</span>lightDir<span class="token punctuation">)</span><span class="token punctuation">;</span>
 <span class="token keyword">vec3</span> v <span class="token operator">=</span> <span class="token function">normalize</span><span class="token punctuation">(</span><span class="token operator">-</span>fPosition<span class="token punctuation">)</span><span class="token punctuation">;</span>
 <span class="token keyword">vec3</span> n <span class="token operator">=</span> <span class="token function">normalize</span><span class="token punctuation">(</span>fNormal<span class="token punctuation">)</span><span class="token punctuation">;</span>
 <span class="token keyword">vec3</span> h <span class="token operator">=</span> <span class="token function">normalize</span><span class="token punctuation">(</span>v<span class="token operator">+</span>s<span class="token punctuation">)</span><span class="token punctuation">;</span>
 <span class="token keyword">float</span> diffuse <span class="token operator">=</span> Ka <span class="token operator">+</span> Kd <span class="token operator">*</span> lightInt <span class="token operator">*</span> <span class="token function">max</span><span class="token punctuation">(</span><span class="token number">0.0</span><span class="token punctuation">,</span> <span class="token function">dot</span><span class="token punctuation">(</span>n<span class="token punctuation">,</span> s<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
 <span class="token keyword">float</span> spec <span class="token operator">=</span>  Ks <span class="token operator">*</span> <span class="token function">pow</span><span class="token punctuation">(</span><span class="token function">max</span><span class="token punctuation">(</span><span class="token number">0.0</span><span class="token punctuation">,</span> <span class="token function">dot</span><span class="token punctuation">(</span>n<span class="token punctuation">,</span>h<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">,</span> shininess<span class="token punctuation">)</span><span class="token punctuation">;</span>
 
 <span class="token keyword">return</span> <span class="token keyword">vec2</span><span class="token punctuation">(</span>diffuse<span class="token punctuation">,</span> spec<span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token keyword">vec3</span> <span class="token function">rim</span><span class="token punctuation">(</span><span class="token keyword">vec3</span> color<span class="token punctuation">,</span> <span class="token keyword">float</span> start<span class="token punctuation">,</span> <span class="token keyword">float</span> end<span class="token punctuation">,</span> <span class="token keyword">float</span> coef<span class="token punctuation">)</span>
<span class="token punctuation">{</span>
 <span class="token keyword">vec3</span> normal <span class="token operator">=</span> <span class="token function">normalize</span><span class="token punctuation">(</span>fNormal<span class="token punctuation">)</span><span class="token punctuation">;</span>
 <span class="token keyword">vec3</span> eye <span class="token operator">=</span> <span class="token function">normalize</span><span class="token punctuation">(</span><span class="token operator">-</span>fPosition<span class="token punctuation">)</span><span class="token punctuation">;</span>
 <span class="token keyword">float</span> rim <span class="token operator">=</span>  <span class="token function">floor</span><span class="token punctuation">(</span><span class="token function">dot</span><span class="token punctuation">(</span>normal<span class="token punctuation">,</span> eye<span class="token punctuation">)</span><span class="token operator">+</span><span class="token number">0.6</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
 <span class="token keyword">return</span> rim <span class="token operator">*</span> coef <span class="token operator">*</span> color<span class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token keyword">void</span> <span class="token function">main</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{</span>
 <span class="token comment">//method 1</span>
 <span class="token keyword">vec3</span> color <span class="token operator">=</span> <span class="token keyword">vec3</span><span class="token punctuation">(</span><span class="token number">0.9</span><span class="token punctuation">,</span> <span class="token number">1.0</span><span class="token punctuation">,</span> <span class="token number">0.3</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
 <span class="token comment">//color = vec3(1.0, 1.0, 1.0);</span>
 color <span class="token operator">=</span> <span class="token function">rim</span><span class="token punctuation">(</span>color<span class="token punctuation">,</span> <span class="token number">0.0</span><span class="token punctuation">,</span> <span class="token number">1.0</span><span class="token punctuation">,</span> <span class="token number">1.0</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
 
 <span class="token keyword">vec3</span> lightDir <span class="token operator">=</span> <span class="token keyword">vec3</span><span class="token punctuation">(</span><span class="token number">1.0</span><span class="token punctuation">,</span> <span class="token number">1.0</span><span class="token punctuation">,</span> <span class="token number">1.0</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
 
 <span class="token keyword">vec2</span> ds <span class="token operator">=</span> <span class="token function">blinnPhongDir</span><span class="token punctuation">(</span>lightDir<span class="token punctuation">,</span> <span class="token number">1.0</span><span class="token punctuation">,</span> <span class="token number">0.3</span><span class="token punctuation">,</span> <span class="token number">0.5</span><span class="token punctuation">,</span> <span class="token number">3.0</span><span class="token punctuation">,</span> <span class="token number">300.0</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
 
 <span class="token keyword">float</span> brightness <span class="token operator">=</span> ds<span class="token punctuation">.</span>x <span class="token operator">+</span> ds<span class="token punctuation">.</span>y<span class="token punctuation">;</span>
 
 brightness <span class="token operator">=</span> <span class="token function">ceil</span><span class="token punctuation">(</span>brightness <span class="token operator">*</span> <span class="token number">3.0</span><span class="token punctuation">)</span><span class="token operator">/</span> <span class="token number">3.0</span><span class="token punctuation">;</span>
 
 gl_FragColor <span class="token operator">=</span> <span class="token keyword">vec4</span><span class="token punctuation">(</span>brightness<span class="token operator">*</span>color<span class="token punctuation">,</span> <span class="token number">1.0</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span>
</code></pre>

