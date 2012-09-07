#include "stdafx.h"

#include "image.h"
#include "image_data_convert.h"

extern LPDIRECT3DDEVICE9   g_pd3dDevice;

#define FOURCC_DXT1	MAKEFOURCC('D', 'X', 'T', '1')
#define FOURCC_DXT3	MAKEFOURCC('D', 'X', 'T', '3')
#define FOURCC_DXT5	MAKEFOURCC('D', 'X', 'T', '5')

#ifdef _WIN32
	#pragma pack(push, dds_struct, 1)
#endif
typedef struct DDSHEAD
{
	UCHAR	Signature[4];

	UINT	Size1;				// size of the structure (minus MagicNum)
	UINT	Flags1; 			// determines what fields are valid
	UINT	Height; 			// height of surface to be created
	UINT	Width;				// width of input surface
	UINT	LinearSize; 		// Formless late-allocated optimized surface size
	UINT	Depth;				// Depth if a volume texture
	UINT	MipMapCount;		// number of mip-map levels requested
	UINT	AlphaBitDepth;		// depth of alpha buffer requested

	UINT	NotUsed[10];

	UINT	Size2;				// size of structure
	UINT	Flags2;				// pixel format flags
	UINT	FourCC;				// (FOURCC code)
	UINT	RGBBitCount;		// how many bits per pixel
	UINT	RBitMask;			// mask for red bit
	UINT	GBitMask;			// mask for green bits
	UINT	BBitMask;			// mask for blue bits
	UINT	RGBAlphaBitMask;	// mask for alpha channel

	UINT	ddsCaps1, ddsCaps2, ddsCaps3, ddsCaps4; // direct draw surface capabilities
	UINT	TextureStage;
}DDSHEAD;
#ifdef _WIN32
	#pragma pack(pop, dds_struct)
#endif


#define LUAIMAGE "LuaImage"

ImageData * lua_checkimage(lua_State *L, int index) 
{
  ImageData** lpimage = (ImageData **)luaL_checkudata(L,index,LUAIMAGE);
  luaL_argcheck(L,lpimage != 0,index,"LuaImage expected");
  return *lpimage;
}

static ImageData** lua_pushimage(lua_State *L) 
{
	ImageData** lpimage = (ImageData **)lua_newuserdata(L,sizeof(ImageData*));
	luaL_getmetatable(L,LUAIMAGE);
	lua_setmetatable(L,-2);
	return lpimage;
}

int l_tex2D( lua_State* L )
{
	ImageData* imgData = lua_checkimage( L, 1 );
	unsigned char* srcData = (unsigned char*)imgData->imgData;

	//double u = lua_tonumber( L, 2 );
	//double v = lua_tonumber( L, 3 );

	int x = int(lua_tonumber( L, 2 ));
	int y = int(lua_tonumber( L, 3 ));

	if( x >= (int)imgData->width )
		x = (int)imgData->width - 1;
	if( y >= (int)imgData->height )
		y = (int)imgData->height - 1;
	if( x < 0 )
		x = 0;
	if( y < 0 )
		y = 0;

	UniPixel out;

	if( imgData->format->readFn )
		imgData->format->readFn( srcData + (y * imgData->width + x) * imgData->format->bytesPerPixel, &out );

	lua_pushnumber( L, out.r );
	lua_pushnumber( L, out.g );
	lua_pushnumber( L, out.b );
	lua_pushnumber( L, out.a );
	return 4;
}

int l_setTex2D( lua_State* L )
{
	ImageData* imgData = lua_checkimage( L, 1 );
	unsigned char* outData = (unsigned char*)imgData->imgData;

	UniPixel in;
	
	int x = int(lua_tonumber( L, 2 ));
	int y = int(lua_tonumber( L, 3 ));

	in.r = (UniPixel::ComponentType)lua_tonumber( L, 4 );
	in.g = (UniPixel::ComponentType)lua_tonumber( L, 5 );
	in.b = (UniPixel::ComponentType)lua_tonumber( L, 6 );
	in.a = (UniPixel::ComponentType)lua_tonumber( L, 7 );

	if( x >= (int)imgData->width )
		x = (int)imgData->width - 1;
	if( y >= (int)imgData->height )
		y = (int)imgData->height - 1;
	if( x < 0 )
		x = 0;
	if( y < 0 )
		y = 0;

	
	void* pixelData = outData + (y * imgData->width + x) * imgData->format->bytesPerPixel;

	if(imgData->format->writeFn)
		imgData->format->writeFn(&in, pixelData);

	return 0;
}

int l_checkImageFormat( lua_State* L )
{
	const char* name = lua_tostring( L, 1 );

	ImageFormat* format = getFormat( name );

	lua_pushboolean( L, format ? 1 : 0 );

	return 1;
}

int l_Image_Create( lua_State* L )
{
	int width = lua_tointeger( L, 1 );
	int height = lua_tointeger( L, 2 );
	const char* fmt = lua_tostring( L, 3 );

	ImageFormat* format = getFormat( fmt );

	//unknown or unsupported format
	if( !format || format->bytesPerPixel <= 0 )
	{
		lua_pushnil( L );
		return 1;
	}
	ImageData* imgData = createImage();
	imgData->width = width;
	imgData->height = height;
	imgData->format = format;
	imgData->imgData = malloc( width * height * format->bytesPerPixel );

	ImageData** luaData = lua_pushimage( L );

	*luaData = imgData;
	return 1;
}

int l_Image_Load( lua_State* L )
{
	D3DXIMAGE_INFO imgInfo;
	const char* fileName = lua_tostring( L, 1 );

	bool dxtCompression = false;
	D3DFORMAT d3dfmt = D3DFMT_UNKNOWN;
	//check for dds format
	{
		if( _strcmpi( "dds", fileName + strlen( fileName ) - 3 ) == 0 )
		{
			DDSHEAD header;
			FILE* f;
			if(fopen_s( &f, fileName, "rb" ) == 0)
			{
				if( fread( &header, sizeof(header), 1, f ) == 1 )
				{
					if( strncmp( (const char*)header.Signature, "DDS ", 4 ) == 0 && ( header.FourCC == D3DFMT_DXT1 || header.FourCC == D3DFMT_DXT3 || header.FourCC == D3DFMT_DXT5 ) )
					{
						d3dfmt = D3DFMT_A8R8G8B8;
					}
				}
				fclose(f);
			}
		}
	}

	LPDIRECT3DTEXTURE9 texture; 

	HRESULT hr = D3DXCreateTextureFromFileEx( g_pd3dDevice, fileName, D3DX_DEFAULT_NONPOW2,  D3DX_DEFAULT_NONPOW2, D3DX_FROM_FILE, 0, d3dfmt, D3DPOOL_SCRATCH, D3DX_DEFAULT, D3DX_DEFAULT, 0, &imgInfo, 0, &texture );

	if( FAILED( hr ) )
	{
		return 0;
	}

	ImageData* imgData = createImage();
	imgData->width = imgInfo.Width;
	imgData->height = imgInfo.Height;
	imgData->format = getFormatByD3D( imgInfo.Format );
	imgData->imgData = malloc( imgData->width * imgData->height * imgData->format->bytesPerPixel );

	D3DLOCKED_RECT rect;
	texture->LockRect(0, &rect, 0, 0 );

	memcpy( imgData->imgData, rect.pBits, imgData->width * imgData->height * imgData->format->bytesPerPixel );

	texture->UnlockRect( 0 );

	texture->Release();

	//lua_pushlightuserdata( L, imgData );

	ImageData** luaData = lua_pushimage( L );

	*luaData = imgData;

	return 1;
}

int l_Image_Width( lua_State* L )
{
	ImageData* imgData = lua_checkimage( L, 1 );

	lua_pushinteger( L, imgData->width );
	return 1;
}

int l_Image_Height( lua_State* L )
{
	ImageData* imgData = lua_checkimage( L, 1 );

	lua_pushinteger( L, imgData->height );
	return 1;
}

int l_Image_Format( lua_State* L )
{
	ImageData* imgData = lua_checkimage( L, 1 );

	lua_pushstring( L, imgData->format->name );
	return 1;
}

int l_Image_Save( lua_State* L )
{
	ImageData* imgData = lua_checkimage( L, 1 );
	const char* fileName = lua_tostring( L, 2 );

	if( !imgData || !fileName )
	{
		lua_pushstring( L, "Wrong parameters to Image_Save functions" );
		lua_error( L );
		return 0;
	}

	LPDIRECT3DTEXTURE9 texture;
	D3DLOCKED_RECT rect;

	g_pd3dDevice->CreateTexture( imgData->width, imgData->height, 1, 0, (D3DFORMAT)imgData->format->d3dformat, D3DPOOL_MANAGED, &texture, 0 );
	texture->LockRect(0, &rect, 0, 0 );
	memcpy( rect.pBits, imgData->imgData, imgData->width * imgData->height * imgData->format->bytesPerPixel );
	texture->UnlockRect( 0 );

	D3DXSaveTextureToFile( fileName, extToFormat(fileName), texture, 0 );

	texture->Release();

	return 0;
}

int l_Image_Delete( lua_State* L )
{
	ImageData* imgData = lua_checkimage( L, 1 );

	free( imgData->imgData );
	deleteImage(imgData);

	return 0;
}
/* quadric related functions are implemented as Quadric userdata methods */
static const luaL_Reg luaimage_methods[] = {
  {"__gc",l_Image_Delete},

  {"Format", l_Image_Format},
  {"Height", l_Image_Height},
  {"Width", l_Image_Width},

  {NULL, NULL}
};

void image_lua_bind(lua_State* L)
{
	luaL_newmetatable(L,LUAIMAGE);
	lua_pushstring(L,"__index");
	lua_pushvalue(L,-2);
	lua_settable(L,-3);
	luaL_register(L,0,luaimage_methods);

	lua_register( L, "checkImageFormat", l_checkImageFormat );
	lua_register( L, "Image_Create", l_Image_Create );
	lua_register( L, "Image_Delete", l_Image_Delete );
	
	lua_register( L, "Image_Load", l_Image_Load );
	lua_register( L, "Image_Save", l_Image_Save );

	lua_register( L, "Image_Tex2D", l_tex2D );
	lua_register( L, "Image_SetTex2D", l_setTex2D );
}