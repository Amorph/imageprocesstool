// stdafx.h : include file for standard system include files,
// or project specific include files that are used frequently, but
// are changed infrequently
//

#pragma once

#include "targetver.h"

#include <stdio.h>
#include <tchar.h>

#include "windows.h"
#include <assert.h>

#include <string>
#include <map>
#include <vector>
#include <iostream>

#include <d3d9.h>
#include <d3dx9.h>

extern "C"
{
	#include <lualib.h>
	#include <lauxlib.h>
}

#include <xnamath.h>

#define COMBINER_WIDTH	2048
#define COMBINER_HEIGHT	2048

#define USE_PREMULTIPLIED_ALPHA 0