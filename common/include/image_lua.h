#ifndef IMAGE_LUA_H__
#define IMAGE_LUA_H__

ImageData * lua_checkimage(lua_State *L, int index);

void image_lua_bind(lua_State* L);

#endif