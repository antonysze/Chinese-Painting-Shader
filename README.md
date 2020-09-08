![enter image description here](https://lh3.googleusercontent.com/u_6Wx_Ebtp34lBk2PIHO_zGgQAE9GMxJU8_ANIhv_bvSNVcsS6T8r4oO0-_K5-IhaeVI7RsBiuU)
![enter image description here](https://lh3.googleusercontent.com/3nbKT7jVPRDi3hDn4dAY2tEeMebfYdeAw3ciR3hXt98esV1-MzLW1v5VcIlXpgaAbsMF8YYKOiY)
### Github Link
https://github.com/antonysze/Chinese-Painting-Shader.git
### Shader Reference
1. [水墨畫search](https://so.csdn.net/so/search/s.do?q=%E6%B0%B4%E5%A2%A8%E7%95%AB+shader&t=blog&o=&s=&l=)
2. [水墨畫 shader](https://blog.csdn.net/nannan0811666/article/details/79452197)
3. [WebGL+shader实现素描效果渲染](https://blog.csdn.net/u011712406/article/details/50085281)
4. [unity3d shader之Roberts,Sobel,Canny 三种边缘检测方法](https://blog.csdn.net/wolf96/article/details/43670851) 
5. [在Unity中如何进行水墨风3D渲染 (雞)](https://zhuanlan.zhihu.com/p/25339585)
6. [Accelerating Harris Algorithm with GPU for Corner Detection](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=6643655)
7. [Ink Brush tutorial 水墨特效教學(Unity+3dsmax+After Effect)](https://www.youtube.com/watch?v=7en8Y0GM55I)
8. [Real Time VFX](https://realtimevfx.com)
9. [Perlin Noise](http://flafla2.github.io/2014/08/09/perlinnoise.html)
10. [optimized single-pass blur shaders for GLSL](https://github.com/Jam3/glsl-fast-gaussian-blur) 

### Paper
1. **Cornell university**
	1. [A Neural Algorithm of Artistic Style](https://github.com/jcjohnson/neural-style)
	2. [Artistic style transfer for videos (implementation of neural-style)](https://github.com/manuelruder/artistic-videos)
	3. [Artistic style transfer for videos and spherical images (faster then above)](https://github.com/manuelruder/artistic-videos)

### Photoshop Reference
[How to Create a Traditional, Chinese Ink Painting Based on a Scenic Photo](https://design.tutsplus.com/tutorials/how-to-create-a-traditional-chinese-ink-painting-based-on-a-scenic-photo--psd-4807)

### Other Reference
1. [Computer Vision I (Penn State University)](http://www.cse.psu.edu/~rtc12/CSE486/)
2. [Unity3D教程宝典之Shader篇：特别讲 CG函数](http://blog.sina.com.cn/s/blog_471132920101dayr.html)

### Tools
1. [Desmos | Graphing Calculator](https://www.desmos.com/calculator)

### Three Js
1. [Uniforms types](https://github.com/mrdoob/three.js/wiki/Uniforms-types)

### ideas & notes
- [not gonna try] ~~Check the normal around the original point by **Sobel Edge Detection**[^4](#shader-reference), the alpha be lower if the normal are very different~~
- inner ink texture base on brightness, not longer uv
- blur inner color then mix the ink texture ( did it )
- edge draw by normal of object shader not working on low poly object like rock, gonna use **Sobel Edge Detection**[^4](#shader-reference) on hole screen shader
- use dissolve to draw inner color

### Progress
![enter image description here](https://lh3.googleusercontent.com/LFPXCVn8Of4CNFTwWpVDz1FHAvK5b8Ygj7ROqcKUmxAQ1PKxUft7-7w8kmbaoNuVAew9JaRBpx8)
