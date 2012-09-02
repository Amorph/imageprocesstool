--Constants
--Filter
POINT = 1
LINEAR = 2


--AddressU,AddressV
WRAP = 1
MIRROR = 2
CLAMP = 3
BORDER = 4
MIRRORONCE = 5

--Mapping
PIXEL = 1
PERCENT = 2

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
sampler_state = function( params )
	--if data == nil then
	local data = {}

	local tex, addressU, addressV, mapping, filter = params.texture, params.addressU, params.addressV, params.mapping, params.filter

	data.data = Sampler_Create( tex.data, addressU, addressV, mapping, filter )

	setmetatable( data, sampler_meta )

	return data
end

