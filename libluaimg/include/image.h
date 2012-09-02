#ifndef IMAGE_H__
#define IMAGE_H__

#include "image_data_convert.h"


typedef void (*readImgDataFn)(void* , UniPixel*);

struct ImageFormat
{
	const char* name;
	int bytesPerPixel;
	unsigned int d3dformat;
	readImgDataFn readFn;
};

struct ImageData
{
	void* imgData;

	size_t width;
	size_t height;

	ImageFormat* format;

	ImageData* nextImageData;
};

ImageFormat supportedFormats[];

ImageFormat* getFormat( const char* name );
ImageFormat* getFormatByD3D( D3DFORMAT fmt );
D3DXIMAGE_FILEFORMAT extToFormat( const char* fileName );

ImageData* createImage();
void deleteImage(ImageData* img);

#endif