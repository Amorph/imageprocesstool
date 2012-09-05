// mkfs.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"



#include <sstream>

extern LPDIRECT3DDEVICE9   g_pd3dDevice;

#include "image.h"
#include "image_lua.h"
#include "sampler_lua.h"

#include "../../builtinscripts/include/builtinscripts.h"

#ifdef _DEBUG
#	define EXPORT_NAME luaopen_luaimg_d
#else
#	define EXPORT_NAME luaopen_luaimg
#endif

HRESULT InitD3D();

extern "C"
{
	__declspec(dllexport) int EXPORT_NAME (lua_State *L)
	{
		HRESULT hr = InitD3D();
		if(FAILED(hr))
		{
			lua_pushstring( L, "Failed to initialize D3D");
			lua_error( L );
			return 0;
		}
		bind_builtin_lua_scripts( L );
		image_lua_bind(L);
		sampler_lua_bind(L);
		//MessageBoxA(0,"Openned","Info",MB_OK);
		return 0;
	}
}
/*
void printError( lua_State* L )
{
	FILE* f = fopen("error.log","a");
	fprintf( f, "%s\n", lua_tostring( L, -1 ) );
	fclose(f);
}*/
/*
int _tmain(int argc, _TCHAR* argv[])
{
	std::cout << "Working..." << std::endl;

	lua_State* L = lua_open();
	luaL_openlibs( L );

	HRESULT hr = InitD3D();
	int res;

	if( FAILED(hr) )
		return 255;

	const char* startScript = argv[1];

	if( argc < 2 )
		return -1;

	image_lua_bind( L );
	sampler_lua_bind( L );
	
	{//include common
		lua_getglobal(L, "require");
		lua_pushstring(L, "common/include");
		res = lua_pcall( L, 1, 0, 0 );
		if(res)
		{
			printError( L );
			return 255;
		}
	}

	res = luaL_dofile( L, startScript );
	if(res)
	{
		printError( L );
		return 255;
	}

	lua_getglobal( L, "main" );
	lua_pushnumber( L, argc - 2 );
	lua_createtable( L, argc - 2, 0 );
	for(int i = 0; i < argc - 2; i++)
	{
		lua_pushinteger( L, i + 1 );
		lua_pushstring( L, argv[2+i] );
		lua_settable( L, -3 );
	}
	res = lua_pcall( L, 2, 0, 0 );
	if(res)
	{
		printError( L );
		return 255;
	}
	lua_gc( L, LUA_GCCOLLECT, 0 );

	lua_close( L );
	
	return 0;
}

*/