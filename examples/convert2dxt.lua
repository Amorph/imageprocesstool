--Add bin path to lib search path
package.cpath = "../bin/?.dll;"..package.cpath

require 'luaimg'

if #arg < 1 then assert( false, "Setup input texture" ) end

outNameDxt1 = string.sub(arg[1],1,-5) .. "_dxt1.dds"
outNameDxt3 = string.sub(arg[1],1,-5) .. "_dxt3.dds"
outNameDxt5 = string.sub(arg[1],1,-5) .. "_dxt5.dds"



-------------------------------------------------------------------------------------------------------------------
--images

inputImg = LoadImage( arg[1] )

outImg1 = CreateImage
{
	width = inputImg.width,
	height = inputImg.height,
	format = "DXT1"
}
outImg3 = CreateImage
{
	width = inputImg.width,
	height = inputImg.height,
	format = "DXT3"
}
outImg5 = CreateImage
{
	width = inputImg.width,
	height = inputImg.height,
	format = "DXT5"
}

-------------------------------------------------------------------------------------------------------------------
--samplers

input = sampler_state{ texture = inputImg, addressU = luaimg.WRAP, addressV = luaimg.WRAP, mapping = luaimg.PIXEL, filter = luaimg.POINT, }

-------------------------------------------------------------------------------------------------------------------
--processing functions

function copy( uv )
	return tex2D( input, uv )
end

-------------------------------------------------------------------------------------------------------------------
--program execution flow

program 'Hello world'
{
	pass 'copy1'
	{
		target = outImg1,
		mapping = PIXEL,
		code = copy,
	},
	pass 'copy3'
	{
		target = outImg3,
		mapping = PIXEL,
		code = copy,
	},
	pass 'copy5'
	{
		target = outImg5,
		mapping = PIXEL,
		code = copy,
	},
	output 'SaveTexture1'
	{
		outFile = outNameDxt1,
		texture = outImg1,
	},
	output 'SaveTexture3'
	{
		outFile = outNameDxt3,
		texture = outImg3,
	},
	output 'SaveTexture5'
	{
		outFile = outNameDxt5,
		texture = outImg5,
	}
}

--Executes all defined programs
luaimg.Exec()
