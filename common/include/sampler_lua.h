#ifndef SAMPLER_LUA_H__
#define SAMPLER_LUA_H__

#include "sampler.h"

SamplerData * lua_checksampler(lua_State *L, int index);

void sampler_lua_bind(lua_State* L);

#endif