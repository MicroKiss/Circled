uPixelH = shader_get_uniform(outlineShader, "pixelH");
uPixelW = shader_get_uniform(outlineShader, "pixelW");

texelW = texture_get_texel_width(sprite_get_texture(sprite_index, 0));
texelH = texture_get_texel_height(sprite_get_texture(sprite_index, 0));