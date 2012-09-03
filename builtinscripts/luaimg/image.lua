--[[
	Supported formats in future :
	R8G8B8,
	A8R8G8B8,
	A8B8G8R8,

	A8,
	L8,
	L16,
	A8L8,

	G16R16,
	A16B16G16R16,

	A2R10G10B10,

	DXT1,
	DXT3,
	DXT5,

	R16F,
	R32F,

	G16R16F,
	G32R32F,
	A16B16G16R16F,
	A32B32G32R32F
]]--

image_meta=
{
	__index= function( self, key )
		if key == "width" then
			return self.data:Width()
		elseif key == "height" then
			return self.data:Height()
		elseif key == "format" then
			return self.data:Format()
		end
		return nil
    end,
	__tostring = function( self )
		return "Image"--"float4("..self.r..","..self.g..","..self.b..","..self.a..")"
	end,
}

--[[
usage
CreateImage{ width=1024, height=1024, format='G16R16F' }
]]--
CreateImage = function( params )
	--if data == nil then
	local data = {}

	local width, height, fmt = params.width, params.height, params.format

	if not checkImageFormat( fmt ) then
		print("Unsupported image format:"..fmt)
		return nil
	end

	data.data = Image_Create( width, height, fmt )

	setmetatable( data, image_meta )

	return data
end

LoadImage = function( fileName )
	local data = {}

	data.data = Image_Load( fileName )
	assert( data.data, "Failed to load image:" .. fileName )

	setmetatable( data, image_meta )

	return data
end

SaveImage = function( img, fileName )
	Image_Save( img.data, fileName )
end

textureFromFile = function( fileName )
	return LoadImage( srcImageName )
end

setTex2D = function( img, uv, color )
	Image_SetTex2D( img.data, uv.x, uv.y, color.r, color.g, color.b, color.a )
end

tex2D = function( img, uv )
	local r, g, b, a = Sampler_Tex2D( img.data, uv.x, uv.y )
	return float4( r, g, b, a )
end

texture_state = CreateImage
