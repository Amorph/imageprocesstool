// mkfs.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"



#include <sstream>

extern LPDIRECT3DDEVICE9   g_pd3dDevice;

#include "image.h"
#include "image_lua.h"
#include "sampler_lua.h"

#include "../../builtinscripts/include/builtinscripts.h"

HRESULT InitD3D();


void printError( lua_State* L )
{
	FILE* f;
	if( fopen_s( &f, "error.log","a" ) == 0 )
	{
		fprintf( f, "%s\n", lua_tostring( L, -1 ) );
		fclose(f);
	}
}

static int getargs (lua_State *L, char **argv, int n) {
	int narg;
	int i;
	int argc = 0;
	while (argv[argc]) argc++;  /* count total number of arguments */

	narg = argc - (n + 1);  /* number of arguments to the script */
	luaL_checkstack(L, narg + 3, "too many arguments to script");

	for (i=n+1; i < argc; i++)
		lua_pushstring(L, argv[i]);

	lua_createtable(L, narg, n + 1);

	for (i=0; i < argc; i++)
	{
		lua_pushstring(L, argv[i]);
		lua_rawseti(L, -2, i - n);
	}
	return narg;
}

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

	bind_builtin_lua_scripts( L );

	image_lua_bind( L );
	sampler_lua_bind( L );

	{//write to package.loaded.luaimg that package loaded
		lua_getglobal( L, "package" );
		lua_getfield( L, -1, "loaded" );
		lua_pushboolean( L, 1 );
		lua_setfield( L, -2, "luaimg" );
	}

	int narg = getargs(L, argv, 1); 
	lua_setglobal(L, "arg");

	res = luaL_dofile( L, startScript );
	if(res)
	{
		printError( L );
		return 255;
	}

	lua_gc( L, LUA_GCCOLLECT, 0 );

	lua_close( L );
	
	return 0;
}
