#ifndef SAMPLER_H__
#define SAMPLER_H__

#include "image.h"

typedef enum _SamplerFilter
{
	SF_POINT = 1,
	SF_LINEAR = 2,

	SF_FORCE_DWORD          =0x7fffffff
}SamplerFilter;

typedef enum _SamplerAddress
{
	SA_WRAP = 1,
	SA_MIRROR = 2,
	SA_CLAMP = 3,
	SA_BORDER = 4,
	SA_MIRRORONCE = 5,

	SA_FORCE_DWORD          =0x7fffffff
}SamplerAddress;

typedef enum _SamplerMappingMethod
{
	SMM_PIXEL = 1,
	SMM_PERCENT = 2,

	SMM_FORCE_DWORD          =0x7fffffff
}SamplerMappingMethod;

struct SamplerData
{
	//TODO add border color, maybe like global value?
	ImageData*				samplingImage;
	int						samplingImageRef;
	
	SamplerFilter			filter;
	SamplerAddress			samplingU;
	SamplerAddress			samplingV;

	SamplerMappingMethod	mapping;

	SamplerData*			nextSamplerData;
};

SamplerData* createSampler();
void deleteSampler(SamplerData* img);

UniPixel tex2D( SamplerData* sampler, const double& u, const double& v );

#endif