#include "stdafx.h"

#include "image.h"
#include "image_data_convert.h"


void readA8R8G8B8( void* src, UniPixel* out )
{
	unsigned char* data = (unsigned char*)src;
	out->v[0] = data[2] / 255.f;
	out->v[1] = data[1] / 255.f;
	out->v[2] = data[0] / 255.f;
	out->v[3] = data[3] / 255.f;
}

void readA16B16G16R16F( void* src, UniPixel* out )
{
	XMVECTOR val = XMLoadHalf4( (XMHALF4*) src );
	out->v[0] = val.m128_f32[0];
	out->v[1] = val.m128_f32[1];
	out->v[2] = val.m128_f32[2];
	out->v[3] = val.m128_f32[3];
}

void readA32B32G32R32F( void* src, UniPixel* out )
{
	float* data = (float*)src;
	out->v[0] = data[0];
	out->v[1] = data[1];
	out->v[2] = data[2];
	out->v[3] = data[3];
}