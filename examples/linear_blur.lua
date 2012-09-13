--Add bin path to lib search path
package.cpath = "../bin/?.dll;"..package.cpath

require 'luaimg'

if #arg < 2 then assert( false, "Setup input and output textures" ) end

-------------------------------------------------------------------------------------------------------------------
--images

inputImg = LoadImage( arg[1] )

horizontalBlurImg = CreateImage
{
	width = inputImg.width,
	height = inputImg.height,
	format = inputImg.format
}

verticalBlurImg = CreateImage
{
	width = inputImg.width,
	height = inputImg.height,
	format = inputImg.format
}

outImg = CreateImage
{
	width = inputImg.width,
	height = inputImg.height,
	format = inputImg.format
}

-------------------------------------------------------------------------------------------------------------------
--samplers

input = sampler_state{ texture = inputImg, addressU = luaimg.WRAP, addressV = luaimg.WRAP, mapping = luaimg.PIXEL, filter = luaimg.POINT, }

hBlur = sampler_state
{
	texture = horizontalBlurImg,
	addressU = luaimg.WRAP,
	addressV = luaimg.WRAP,
	mapping = luaimg.PIXEL,
	filter = luaimg.POINT,
}

vBlur = sampler_state
{
	texture = verticalBlurImg,
	addressU = luaimg.WRAP,
	addressV = luaimg.WRAP,
	mapping = luaimg.PIXEL,
	filter = luaimg.POINT,
}

-------------------------------------------------------------------------------------------------------------------
--processing functions

function horizontalBlur( uv )
	local color =   tex2D( input, uv - float2(-2,0) )
	color = color + tex2D( input, uv - float2(-1,0) )
	color = color + tex2D( input, uv - float2( 0,0) )
	color = color + tex2D( input, uv - float2( 1,0) )
	color = color + tex2D( input, uv - float2( 2,0) )
	return color / 5
end

function verticalBlur( uv )
	local color =   tex2D( input, uv - float2(0,-2) )
	color = color + tex2D( input, uv - float2(0,-1) )
	color = color + tex2D( input, uv - float2(0, 0) )
	color = color + tex2D( input, uv - float2(0, 1) )
	color = color + tex2D( input, uv - float2(0, 2) )
	return color / 5
end

function merge( uv )
	return ( tex2D( hBlur, uv ) + tex2D( vBlur, uv ) ) / 2
end

-------------------------------------------------------------------------------------------------------------------
--program execution flow

program 'Hello world'
{
	pass 'horizontalBlur'
	{
		target = horizontalBlurImg,
		mapping = inputImg.PIXEL,
		code = horizontalBlur,
	},
	pass 'verticalBlur'
	{
		target = verticalBlurImg,
		mapping = inputImg.PIXEL,
		code = verticalBlur,
	},
	pass 'merge'
	{
		target = outImg,
		mapping = inputImg.PIXEL,
		code = merge,
	},
	output 'SaveTexture'
	{
		outFile = arg[2],
		texture = outImg,
	}
}

--Executes all defined programs
luaimg.Exec()
