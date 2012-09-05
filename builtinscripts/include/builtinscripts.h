#ifndef __BUILTINT_SCRIPTS_H__
#define __BUILTINT_SCRIPTS_H__


#ifdef __cplusplus
extern "C"
{
#endif
	typedef struct lua_State lua_State;

	void bind_builtin_lua_scripts( lua_State* L );

#ifdef __cplusplus
}
#endif
#endif