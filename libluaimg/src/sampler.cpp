#include "stdafx.h"

#include "sampler.h"
#include "image.h"

static SamplerData* images = 0;

SamplerData* createSampler()
{
	SamplerData* img = (SamplerData*)malloc(sizeof(SamplerData));
	img->nextSamplerData = images;
	images = img;
	return img;
}

void deleteSampler(SamplerData* img)
{
	SamplerData* head = images;
	SamplerData* prev = 0;
	while( head )
	{
		if( head == img )
		{
			SamplerData* next = head->nextSamplerData;
			if( prev )
			{
				prev->nextSamplerData = next;
			}else
			{
				images = next;
			}
			free(head);
			break;
		}

		prev = head;

		head = head->nextSamplerData;
	}
}

UniPixel tex2D( SamplerData* sampler, const double& su, const double& sv )
{
	UniPixel result;

	double u = su;
	double v = sv;

	if( sampler->mapping == SMM_PERCENT )
	{
		u = su * sampler->samplingImage->width - 0.5;
		v = sv * sampler->samplingImage->height - 0.5;
	}

	size_t imgWidth = sampler->samplingImage->width;
	size_t imgHeight = sampler->samplingImage->height;

	//TODO check mirroring in all states
	if( sampler->filter == SF_POINT )
	{
		//TODO: try add round 
		u = floor(u/* + 0.5*/);
		v = floor(v/* + 0.5*/);
		switch(sampler->samplingU)
		{
		case SA_WRAP:
			u = fmod( u, imgWidth );
			u = u < 0 ? imgWidth + u : u;
				break;
		default:
			assert(!"Unknown sampling state");
			break;
		};
		switch(sampler->samplingV)
		{
		case SA_WRAP:
			v = fmod( v, imgHeight );
			v = v < 0 ? imgHeight + v : v;
			break;
		default:
			assert(!"Unknown sampling state");
			break;
		};
		assert( !( v < 0.0 || u < 0.0 || u > imgWidth - 1 || v > imgHeight - 1 ) && "Wrong sampling address" );

		unsigned char* srcData = (unsigned char*)sampler->samplingImage->imgData;

		assert( sampler->samplingImage->format->readFn && "No sampling implementation in format" );
		sampler->samplingImage->format->readFn( srcData + (size_t(v) * imgWidth + size_t(u)) * sampler->samplingImage->format->bytesPerPixel, &result );

		return result;
	}

	return result;
}