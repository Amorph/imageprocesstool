#ifndef IMAGE_DATA_CONVERT_H__
#define IMAGE_DATA_CONVERT_H__

#pragma pack(push)
#pragma pack(1)

typedef struct _UniPixel
{
	union {
        struct {
            float        r,g,b,a;
        };
        float v[4];
    };
}UniPixel;

#pragma pack(pop)

void readA8R8G8B8( void* src, UniPixel* out );
void readA16B16G16R16F( void* src, UniPixel* out );
void readA32B32G32R32F( void* src, UniPixel* out );

#endif