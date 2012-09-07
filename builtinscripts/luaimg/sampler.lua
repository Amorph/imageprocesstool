--Constants
--Filter
luaimg.POINT = 1
luaimg.LINEAR = 2


--AddressU,AddressV
luaimg.WRAP = 1
luaimg.MIRROR = 2
luaimg.CLAMP = 3
luaimg.BORDER = 4
luaimg.MIRRORONCE = 5

--Mapping
luaimg.PIXEL = 1
luaimg.PERCENT = 2

sampler_meta=
{
	__tostring = function( self )
		return "Sampler"--"float4("..self.r..","..self.g..","..self.b..","..self.a..")"
	end,
	__gc = function( self )
		Sampler_Delete( self.data )
	end
}

--[[
usage
sampler_state{
	texture = texture1,
	addressU = WRAP,
	addressV = CLAMP,
	mapping = PIXEL, --PERCENT
	filter = POINT
};
]]--
luaimg.sampler_state = function( params )
	assert( params ~= nil, "Wrong arguments" )
	local data = {}

	local tex, addressU, addressV, mapping, filter = params.texture, params.addressU, params.addressV, params.mapping, params.filter

	assert( tex ~= nil, "Invalid texture" )

	data.data = Sampler_Create( tex.data, addressU, addressV, mapping, filter )

	setmetatable( data, sampler_meta )

	return data
end

sampler_state = luaimg.sampler_state
