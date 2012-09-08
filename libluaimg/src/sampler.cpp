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

double calcAddressing( SamplerAddress address, const size_t& imgSize, const double& input )
{
	double tmp;
	switch( address )
	{
		case SA_WRAP:
			tmp = fmod( input, imgSize );
			return tmp < 0 ? imgSize + tmp : tmp;
		case SA_CLAMP:
			if( input < 0.0 )
				return 0.0;
			if( input > (imgSize - 1.0) )
				return imgSize - 1.0;
			return input;
		case SA_MIRROR:
		{
			tmp = input < 0 ? abs(input + 1) : input;

			if( int((tmp) / (imgSize)) % 2 )
				return imgSize - fmod( tmp, imgSize ) - 1;
			return fmod( tmp, imgSize );
		}
	};
	assert(!"Wrong address mode");
	return input;
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

		u = calcAddressing( sampler->samplingU, imgWidth, u );
		v = calcAddressing( sampler->samplingV, imgHeight, v );
		
		assert( !( v < 0.0 || u < 0.0 || u > imgWidth - 1 || v > imgHeight - 1 ) && "Wrong sampling address" );

		unsigned char* srcData = (unsigned char*)sampler->samplingImage->imgData;

		assert( sampler->samplingImage->format->readFn && "No sampling implementation in format" );
		sampler->samplingImage->format->readFn( srcData + (size_t(v) * imgWidth + size_t(u)) * sampler->samplingImage->format->bytesPerPixel, &result );

		return result;
	}

	return result;
}