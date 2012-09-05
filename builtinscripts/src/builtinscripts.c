#include "builtinscripts.h"



void bind_builtin_lua_scripts( lua_State* L )
{
#	include "luaimg/common.h"
#	include "luaimg/float2.h"
#	include "luaimg/float3.h"
#	include "luaimg/float4.h"
#	include "luaimg/hlsl_math.h"
#	include "luaimg/image.h"
#	include "luaimg/program.h"
#	include "luaimg/program_parse.h" 
#	include "luaimg/sampler.h" 
}