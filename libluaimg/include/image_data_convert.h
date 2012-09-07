#ifndef IMAGE_DATA_CONVERT_H__
#define IMAGE_DATA_CONVERT_H__

#pragma pack(push)
#pragma pack(1)

typedef struct _UniPixel
{
	typedef float ComponentType;
	union {
        struct {
            ComponentType        r,g,b,a;
        };
        ComponentType v[4];
    };
}UniPixel;

#pragma pack(pop)

void readR8G8B8( void* src, UniPixel* out );
void readA8R8G8B8( void* src, UniPixel* out );
void readA16B16G16R16F( void* src, UniPixel* out );
void readA32B32G32R32F( void* src, UniPixel* out );

void readA8( void* src, UniPixel* out );
void readL8( void* src, UniPixel* out );
void readL16( void* src, UniPixel* out );
void readA8L8( void* src, UniPixel* out );

void readG16R16( void* src, UniPixel* out );
void readA16B16G16R16( void* src, UniPixel* out );

void readA2R10G10B10( void* src, UniPixel* out );

void readR16F( void* src, UniPixel* out );
void readR32F( void* src, UniPixel* out );

void readG16R16F( void* src, UniPixel* out );
void readG32R32F( void* src, UniPixel* out );


void writeR8G8B8( UniPixel* src, void* out );
void writeA8R8G8B8( UniPixel* src, void* out );
void writeA16B16G16R16F( UniPixel* src, void* out );
void writeA32B32G32R32F( UniPixel* src, void* out );

void writeA8( UniPixel* src, void* out );
void writeL8( UniPixel* src, void* out );
void writeL16( UniPixel* src, void* out );
void writeA8L8( UniPixel* src, void* out );

void writeG16R16( UniPixel* src, void* out );
void writeA16B16G16R16( UniPixel* src, void* out );

void writeA2R10G10B10( UniPixel* src, void* out );

void writeR16F( UniPixel* src, void* out );
void writeR32F( UniPixel* src, void* out );

void writeG16R16F( UniPixel* src, void* out );
void writeG32R32F( UniPixel* src, void* out );


#endif