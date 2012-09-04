--Add bin path to lib search path
package.cpath = "../bin/?.dll;"..package.cpath

require 'luaimg'


--imageprocesstool.exe must work with args in same way as lua.exe
if #arg < 2 then assert( false, "Setup input and output textures" ) end

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


--samplers
input = sampler_state
{
	texture = inputImg,
	addressU = WRAP,
	addressV = WRAP,
	mapping = PIXEL,
	filter = POINT,
}

hBlur = sampler_state
{
	texture = horizontalBlurImg,
	addressU = WRAP,
	addressV = WRAP,
	mapping = PIXEL,
	filter = POINT,
}

vBlur = sampler_state
{
	texture = verticalBlurImg,
	addressU = WRAP,
	addressV = WRAP,
	mapping = PIXEL,
	filter = POINT,
}


function horizontalBlur( uv )
	local c0 = tex2D( input, uv - float2(-1,0) )
	local c1 = tex2D( input, uv - float2(-0,0) )
	local c2 = tex2D( input, uv - float2( 1,0) )
	return (c0 + c1 + c2) / 3
end

function verticalBlur( uv )
	local c0 = tex2D( input, uv - float2(0,-1) )
	local c1 = tex2D( input, uv - float2(0,-0) )
	local c2 = tex2D( input, uv - float2(0, 1) )
	return (c0 + c1 + c2) / 3
end

function merge( uv )
	return ( tex2D( hBlur, uv ) + tex2D( vBlur, uv ) ) / 2
end



program 'Hello world'
{
	pass 'horizontalBlur'
	{
		target = horizontalBlurImg,
		mapping = PIXEL,
		code = horizontalBlur,
	},
	pass 'verticalBlur'
	{
		target = verticalBlurImg,
		mapping = PIXEL,
		code = verticalBlur,
	},
	pass 'merge'
	{
		target = outImg,
		mapping = PIXEL,
		code = merge,
	},
	output 'SaveTexture'
	{
		fileName = arg[2],
		texture = outImg,
	}
}

--Executes all defined programs
luaimg.Exec()
