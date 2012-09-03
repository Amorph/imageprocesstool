--Add bin path to lib search path
package.cpath = "../bin/?.dll;"..package.cpath

require 'luaimg'


--imageprocesstool.exe must work with args in same way as lua.exe
if #arg < 2 then assert("Setup input and output textures") end

--Loading image into inputImg variable
inputImg = LoadImage( arg[1] )

--Creating output image with same size and format
outImg = CreateImage
{
	width = inputImg.width,
	height = inputImg.height,
	format = inputImg.format
}

--Creating texture sampler for reading input texture
input = sampler_state
{
	texture = inputImg,
	addressU = WRAP,
	addressV = WRAP,
	mapping = PIXEL,
	filter = POINT,
}

--This function executes for every pixel of output texture
function copyFunction( uv )
	--Just read and returns pixel from input texture( via input sampler )
	return tex2D( input, uv )
end

--Block that describes program flow
--Passes have must specify output texture and code function that will be executed for every pixel
--Output block describes save operations
program 'Hello world'
{
	pass 'Copy'
	{
		target = outImg,
		mapping = PIXEL,
		code = copyFunction,
	},
	output 'SaveCopyTexture'
	{
		fileName = arg[2],
		texture = outImg,
	}
}

--Executes all defined programs
luaimg.Exec()
