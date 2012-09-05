#include "stdafx.h"


extern "C"
{
	#include <lualib.h>
	#include <lauxlib.h>
}

#include <d3d9.h>
#include <d3dx9.h>

#include "image.h"
#include "image_data_convert.h"

ImageFormat supportedFormats[]=
{
	{"R8G8B8",3,D3DFMT_R8G8B8,readR8G8B8},
	//{"R8G8B8A8",4,D3DFMT_UNKNOWN,0},
	{"A8R8G8B8",4,D3DFMT_A8R8G8B8,readA8R8G8B8},
	{"X8R8G8B8",4,D3DFMT_X8R8G8B8,readA8R8G8B8},
	//{"A8B8G8R8",4,D3DFMT_UNKNOWN,0},
	
	{"A8",1,D3DFMT_A8,readA8},
	{"L8",1,D3DFMT_L8,readL8},
	{"L16",2,D3DFMT_L16,readL16},
	{"A8L8",2,D3DFMT_A8L8,readA8L8},
	
	{"G16R16",4,D3DFMT_G16R16,readG16R16},
	{"A16B16G16R16",8,D3DFMT_A16B16G16R16,readA16B16G16R16},
	
	{"A2R10G10B10",4,D3DFMT_A2R10G10B10,readA2R10G10B10},
	
	{"DXT1",4,D3DFMT_DXT1,readA8R8G8B8},
	{"DXT3",4,D3DFMT_DXT3,readA8R8G8B8},
	{"DXT5",4,D3DFMT_DXT5,readA8R8G8B8},
	
	{"R16F",2,D3DFMT_R16F,readR16F},
	{"R32F",4,D3DFMT_R32F,readR32F},
	
	{"G16R16F",4,D3DFMT_G16R16F,readG16R16F},
	{"G32R32F",8,D3DFMT_G32R32F,readG32R32F},
	{"A16B16G16R16F",8,D3DFMT_A16B16G16R16F,readA16B16G16R16F},
	{"A32B32G32R32F",16,D3DFMT_A32B32G32R32F,readA32B32G32R32F},

	{0,-1,D3DFMT_UNKNOWN},
};

static ImageData* images = 0;

ImageData* createImage()
{
	ImageData* img = (ImageData*)malloc(sizeof(ImageData));
	img->nextImageData = images;
	images = img;
	return img;
}

void deleteImage(ImageData* img)
{
	ImageData* head = images;
	ImageData* prev = 0;
	while( head )
	{
		if( head == img )
		{
			ImageData* next = head->nextImageData;
			if( prev )
			{
				prev->nextImageData = next;
			}else
			{
				images = next;
			}
			free(head);
			break;
		}

		prev = head;

		head = head->nextImageData;
	}
}

ImageFormat* getFormat( const char* name )
{
	ImageFormat* res = 0;

	size_t i = 0;
	while( supportedFormats[i].name )
	{
		if( _stricmp( name, supportedFormats[i].name ) == 0 )
		{
			res = &supportedFormats[i];
			break;
		}
		i++;
	}
	return res;
}

ImageFormat* getFormatByD3D( D3DFORMAT fmt )
{
	if( fmt == D3DFMT_UNKNOWN )
		return 0;

	ImageFormat* res = 0;

	size_t i = 0;
	while( supportedFormats[i].name )
	{
		if( supportedFormats[i].d3dformat == fmt )
		{
			res = &supportedFormats[i];
			break;
		}
		i++;
	}
	return res;
}

D3DXIMAGE_FILEFORMAT extToFormat( const char* fileName )
{
	int len = strlen( fileName );
	const char* toCompare = fileName + len - 3;
	if( _strcmpi( toCompare, "png" ) == 0 )
		return D3DXIFF_PNG;
	else if( _strcmpi( toCompare, "dds" ) == 0 )
		return D3DXIFF_DDS;
	else if( _strcmpi( toCompare, "bmp" ) == 0 )
		return D3DXIFF_BMP;
	else if( _strcmpi( toCompare, "jpg" ) == 0 )
		return D3DXIFF_JPG;
	else if( _strcmpi( toCompare, "tga" ) == 0 )
		return D3DXIFF_TGA;
	else if( _strcmpi( toCompare, "ppm" ) == 0 )
		return D3DXIFF_PPM;
	else if( _strcmpi( toCompare, "dib" ) == 0 )
		return D3DXIFF_DIB;
	else if( _strcmpi( toCompare, "hdr" ) == 0 )
		return D3DXIFF_HDR;
	else if( _strcmpi( toCompare, "pfm" ) == 0 )
		return D3DXIFF_PFM;
	return D3DXIFF_FORCE_DWORD;
}