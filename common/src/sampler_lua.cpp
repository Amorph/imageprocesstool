#include "stdafx.h"

#include "image.h"
#include "sampler.h"
#include "image_data_convert.h"
#include "image_lua.h"

#define LUASAMPLER "LuaSampler"

SamplerData * lua_checksampler(lua_State *L, int index) 
{
  SamplerData** smlprData = (SamplerData **)luaL_checkudata(L,index,LUASAMPLER);
  luaL_argcheck(L,smlprData != 0,index,"LuaSampler expected");
  return *smlprData;
}

static SamplerData** lua_pushsampler(lua_State *L) 
{
	SamplerData** smlprData = (SamplerData **)lua_newuserdata(L,sizeof(SamplerData*));
	luaL_getmetatable(L,LUASAMPLER);
	lua_setmetatable(L,-2);
	return smlprData;
}


int l_Sampler_Tex2D( lua_State* L )
{
	SamplerData* smlprData = lua_checksampler( L, 1 );

	double x = lua_tonumber( L, 2 );
	double y = lua_tonumber( L, 3 );

	UniPixel out = tex2D( smlprData, x, y );

	/*if( imgData->format->readFn )
		imgData->format->readFn( srcData + (y * imgData->width + x) * imgData->format->bytesPerPixel, &out );*/

	lua_pushnumber( L, out.r );
	lua_pushnumber( L, out.g );
	lua_pushnumber( L, out.b );
	lua_pushnumber( L, out.a );
	return 4;
}



int l_Sampler_Create( lua_State* L )
{
	lua_pushvalue(L, 2);
	int imgRef = luaL_ref(L, LUA_REGISTRYINDEX);

	ImageData* img = lua_checkimage( L, 1 );
	SamplerAddress saddrU = (SamplerAddress)lua_tointeger( L, 2 );
	SamplerAddress saddrV = (SamplerAddress)lua_tointeger( L, 3 );
	SamplerMappingMethod smapping = (SamplerMappingMethod)lua_tointeger( L, 4 );
	SamplerFilter sfilter = (SamplerFilter)lua_tointeger( L, 5 );
	/*int width = lua_tointeger( L, 1 );
	int height = lua_tointeger( L, 2 );
	const char* fmt = lua_tostring( L, 3 );

	ImageFormat* format = getFormat( fmt );

	//unknown or unsupported format
	if( !format || format->bytesPerPixel <= 0 )
	{
		lua_pushnil( L );
		return 1;
	}*/
	SamplerData* smlprData = createSampler();
	smlprData->samplingImage = img;
	smlprData->samplingImageRef = imgRef;
	smlprData->samplingU = saddrU;
	smlprData->samplingV = saddrV;
	smlprData->mapping = smapping;
	smlprData->filter = sfilter;

	SamplerData** luaData = lua_pushsampler( L );

	*luaData = smlprData;
	return 1;
}


int l_Sampler_Delete( lua_State* L )
{
	SamplerData* smlprData = lua_checksampler( L, 1 );
	luaL_unref( L, LUA_REGISTRYINDEX, smlprData->samplingImageRef );
	//free( smlprData->imgData );
	deleteSampler(smlprData);

	return 0;
}
/* quadric related functions are implemented as Quadric userdata methods */
static const luaL_Reg luasampler_methods[] = {
  {"__gc",l_Sampler_Delete},

  {NULL, NULL}
};

void sampler_lua_bind(lua_State* L)
{
	luaL_newmetatable(L,LUASAMPLER);
	lua_pushstring(L,"__index");
	lua_pushvalue(L,-2);
	lua_settable(L,-3);
	luaL_register(L,0,luasampler_methods);

	lua_register( L, "Sampler_Create", l_Sampler_Create );
	lua_register( L, "Sampler_Delete", l_Sampler_Delete );
	lua_register( L, "Sampler_Tex2D", l_Sampler_Tex2D );
	
	//lua_register( L, "Sampler_Tex2D", l_tex2D );
}