#include "stdafx.h"

#include "sampler.h"
#include "image.h"

static SamplerData* images = 0;

void uniPixelLerp( UniPixel* result, UniPixel* x, UniPixel* y, double coef )
{
	result->v[0] = x->v[0] + (y->v[0] - x->v[0]) * coef;
	result->v[1] = x->v[1] + (y->v[1] - x->v[1]) * coef;
	result->v[2] = x->v[2] + (y->v[2] - x->v[2]) * coef;
	result->v[3] = x->v[3] + (y->v[3] - x->v[3]) * coef;
}

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

		
		u = floor(u + 0.5);
		v = floor(v + 0.5);

		u = calcAddressing( sampler->samplingU, imgWidth, u );
		v = calcAddressing( sampler->samplingV, imgHeight, v );

		
		assert( !( v < 0.0 || u < 0.0 || u > imgWidth - 1 || v > imgHeight - 1 ) && "Wrong sampling address" );

		unsigned char* srcData = (unsigned char*)sampler->samplingImage->imgData;

		assert( sampler->samplingImage->format->readFn && "No sampling implementation in format" );
		sampler->samplingImage->format->readFn( srcData + (size_t(v) * imgWidth + size_t(u)) * sampler->samplingImage->format->bytesPerPixel, &result );

		return result;
	}else if( sampler->filter == SF_LINEAR )
	{
		double minU = floor(u);
		double minV = floor(v);
		double maxU = ceil(u);
		double maxV = ceil(v);

		double blendCoefU = u - minU;
		double blendCoefV = v - minV;
		
		minU = calcAddressing( sampler->samplingU, imgWidth, minU );
		maxU = calcAddressing( sampler->samplingU, imgWidth, maxU );

		minV = calcAddressing( sampler->samplingV, imgHeight, minV );
		maxV = calcAddressing( sampler->samplingV, imgHeight, maxV );
		
		unsigned char* srcData = (unsigned char*)sampler->samplingImage->imgData;

		UniPixel q0;
		UniPixel q1;

		UniPixel q2;
		UniPixel q3;

		sampler->samplingImage->format->readFn( srcData + (size_t(minV) * imgWidth + size_t(minU)) * sampler->samplingImage->format->bytesPerPixel, &q0 );
		sampler->samplingImage->format->readFn( srcData + (size_t(minV) * imgWidth + size_t(maxU)) * sampler->samplingImage->format->bytesPerPixel, &q1 );

		sampler->samplingImage->format->readFn( srcData + (size_t(maxV) * imgWidth + size_t(minU)) * sampler->samplingImage->format->bytesPerPixel, &q2 );
		sampler->samplingImage->format->readFn( srcData + (size_t(maxV) * imgWidth + size_t(maxU)) * sampler->samplingImage->format->bytesPerPixel, &q3 );

		UniPixel linear0;
		UniPixel linear1;
		
		uniPixelLerp( &linear0, &q0, &q1, blendCoefU );
		uniPixelLerp( &linear1, &q2, &q3, blendCoefU );

		uniPixelLerp( &result, &linear0, &linear1, blendCoefV );
	}

	return result;
}