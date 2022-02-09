shader_set (outlineShader);
shader_set_uniform_f (uPixelW, texelW);
shader_set_uniform_f (uPixelH, texelH);
draw_self ();
shader_reset ();