
function min( x, y )
	local typeX = type(x)
	local typeY = type(y)
	local mathfunc = math.min
	if typeX ~= typeY or ( x == nil or y == nil ) then
		assert(false, "Can't eval min for types '" .. typeX .. "' to '" .. typeY .. "'" )
	elseif typeX == "number" then
		return mathfunc( x, y )
	elseif typeX == "float4" then
		return float4( mathfunc( x.x, y.x ), mathfunc( x.y, y.y ), mathfunc( x.z, y.z ), mathfunc( x.w, y.w ) )
	elseif typeX == "float3" then
		return float3( mathfunc( x.x, y.x ), mathfunc( x.y, y.y ), mathfunc( x.z, y.z ) )
	elseif typeX == "float2" then
		return float2( mathfunc( x.x, y.x ), mathfunc( x.y, y.y ) )
	end
	assert(false, "Can't eval min for types '" .. typeX .. "' to '" .. typeY .. "'" )
end

function max( x, y )
	local typeX = type(x)
	local typeY = type(y)
	local mathfunc = math.max
	if typeX ~= typeY or ( x == nil or y == nil ) then
		assert(false, "Can't eval max for types '" .. typeX .. "' to '" .. typeY .. "'" )
	elseif typeX == "number" then
		return mathfunc( x, y )
	elseif typeX == "float4" then
		return float4( mathfunc( x.x, y.x ), mathfunc( x.y, y.y ), mathfunc( x.z, y.z ), math.max( x.w, y.w ) )
	elseif typeX == "float3" then
		return float3( mathfunc( x.x, y.x ), mathfunc( x.y, y.y ), mathfunc( x.z, y.z ) )
	elseif typeX == "float2" then
		return float2( mathfunc( x.x, y.x ), mathfunc( x.y, y.y ) )
	end
	assert(false, "Can't eval max for types '" .. typeX .. "' to '" .. typeY .. "'" )
end

function abs( x )
	local typeX = type(x)
	local mathfunc = math.abs
	if x == nil then
		assert(false, "Can't eval abs for type '" .. typeX .. "'" )
	elseif typeX == "number" then
		return mathfunc( x )
	elseif typeX == "float4" then
		return float4( mathfunc( x.x ), mathfunc( x.y ), mathfunc( x.z ), mathfunc( x.w ) )
	elseif typeX == "float3" then
		return float3( mathfunc( x.x ), mathfunc( x.y ), mathfunc( x.z ) )
	elseif typeX == "float2" then
		return float2( mathfunc( x.x ), mathfunc( x.y ) )
	end
	assert(false, "Can't eval abs for type '" .. typeX .. "'" )
end

function acos( x )
	local typeX = type(x)
	local mathfunc = math.acos
	if x == nil then
		assert(false, "Can't eval acos for type '" .. typeX .. "'" )
	elseif typeX == "number" then
		return mathfunc( x )
	elseif typeX == "float4" then
		return float4( mathfunc( x.x ), mathfunc( x.y ), mathfunc( x.z ), mathfunc( x.w ) )
	elseif typeX == "float3" then
		return float3( mathfunc( x.x ), mathfunc( x.y ), mathfunc( x.z ) )
	elseif typeX == "float2" then
		return float2( mathfunc( x.x ), mathfunc( x.y ) )
	end
	assert(false, "Can't eval acos for type '" .. typeX .. "'" )
end

function asin( x )
	local typeX = type(x)
	local mathfunc = math.asin
	if x == nil then
		assert(false, "Can't eval asin for type '" .. typeX .. "'" )
	elseif typeX == "number" then
		return mathfunc( x )
	elseif typeX == "float4" then
		return float4( mathfunc( x.x ), mathfunc( x.y ), mathfunc( x.z ), mathfunc( x.w ) )
	elseif typeX == "float3" then
		return float3( mathfunc( x.x ), mathfunc( x.y ), mathfunc( x.z ) )
	elseif typeX == "float2" then
		return float2( mathfunc( x.x ), mathfunc( x.y ) )
	end
	assert(false, "Can't eval asin for type '" .. typeX .. "'" )
end

function atan( x )
	local typeX = type(x)
	local mathfunc = math.atan
	if x == nil then
		assert(false, "Can't eval atan for type '" .. typeX .. "'" )
	elseif typeX == "number" then
		return mathfunc( x )
	elseif typeX == "float4" then
		return float4( mathfunc( x.x ), mathfunc( x.y ), mathfunc( x.z ), mathfunc( x.w ) )
	elseif typeX == "float3" then
		return float3( mathfunc( x.x ), mathfunc( x.y ), mathfunc( x.z ) )
	elseif typeX == "float2" then
		return float2( mathfunc( x.x ), mathfunc( x.y ) )
	end
	assert(false, "Can't eval atan for type '" .. typeX .. "'" )
end

function cos( x )
	local typeX = type(x)
	local mathfunc = math.cos
	if x == nil then
		assert(false, "Can't eval cos for type '" .. typeX .. "'" )
	elseif typeX == "number" then
		return mathfunc( x )
	elseif typeX == "float4" then
		return float4( mathfunc( x.x ), mathfunc( x.y ), mathfunc( x.z ), mathfunc( x.w ) )
	elseif typeX == "float3" then
		return float3( mathfunc( x.x ), mathfunc( x.y ), mathfunc( x.z ) )
	elseif typeX == "float2" then
		return float2( mathfunc( x.x ), mathfunc( x.y ) )
	end
	assert(false, "Can't eval cos for type '" .. typeX .. "'" )
end

function sin( x )
	local typeX = type(x)
	local mathfunc = math.sin
	if x == nil then
		assert(false, "Can't eval sin for type '" .. typeX .. "'" )
	elseif typeX == "number" then
		return mathfunc( x )
	elseif typeX == "float4" then
		return float4( mathfunc( x.x ), mathfunc( x.y ), mathfunc( x.z ), mathfunc( x.w ) )
	elseif typeX == "float3" then
		return float3( mathfunc( x.x ), mathfunc( x.y ), mathfunc( x.z ) )
	elseif typeX == "float2" then
		return float2( mathfunc( x.x ), mathfunc( x.y ) )
	end
	assert(false, "Can't eval sin for type '" .. typeX .. "'" )
end

function tan( x )
	local typeX = type(x)
	local mathfunc = math.tan
	if x == nil then
		assert(false, "Can't eval tan for type '" .. typeX .. "'" )
	elseif typeX == "number" then
		return mathfunc( x )
	elseif typeX == "float4" then
		return float4( mathfunc( x.x ), mathfunc( x.y ), mathfunc( x.z ), mathfunc( x.w ) )
	elseif typeX == "float3" then
		return float3( mathfunc( x.x ), mathfunc( x.y ), mathfunc( x.z ) )
	elseif typeX == "float2" then
		return float2( mathfunc( x.x ), mathfunc( x.y ) )
	end
	assert(false, "Can't eval tan for type '" .. typeX .. "'" )
end

function ceil( x )
	local typeX = type(x)
	local mathfunc = math.ceil
	if x == nil then
		assert(false, "Can't eval ceil for type '" .. typeX .. "'" )
	elseif typeX == "number" then
		return mathfunc( x )
	elseif typeX == "float4" then
		return float4( mathfunc( x.x ), mathfunc( x.y ), mathfunc( x.z ), mathfunc( x.w ) )
	elseif typeX == "float3" then
		return float3( mathfunc( x.x ), mathfunc( x.y ), mathfunc( x.z ) )
	elseif typeX == "float2" then
		return float2( mathfunc( x.x ), mathfunc( x.y ) )
	end
	assert(false, "Can't eval ceil for type '" .. typeX .. "'" )
end

function clamp( x, y, z )
	local typeX = type(x)
	local typeY = type(y)
	local typeZ = type(z)
	local mathfunc = function( cx, cmin, cmax ) if cx < cmin then return cmin elseif cx > cmax then return cmax else return cx end end
	if typeX ~= typeY or  typeY ~= typeZ or ( x == nil or y == nil or z == nil) then
		assert(false, "Can't eval clamp for x='" .. typeX .. "' min='" .. typeY .. "'" .. "' max='" .. typeZ .. "'" )
	elseif typeX == "number" then
		return mathfunc( x, y, z )
	elseif typeX == "float4" then
		return float4( mathfunc( x.x, y.x, z.x ), mathfunc( x.y, y.y, z.y ), mathfunc( x.z, y.z, z.z ), mathfunc( x.w, y.w, z.w ) )
	elseif typeX == "float3" then
		return float3( mathfunc( x.x, y.x, z.x ), mathfunc( x.y, y.y, z.y ), mathfunc( x.z, y.z, z.z ) )
	elseif typeX == "float2" then
		return float2( mathfunc( x.x, y.x, z.x ), mathfunc( x.y, y.y, z.y ) )
	end
	assert(false, "Can't eval clamp for x='" .. typeX .. "' min='" .. typeY .. "'" .. "' max='" .. typeZ .. "'" )
end

function saturate( x )
	local typeX = type(x)
	if typeX == "number" then
		return clamp( x, 0, 1 )
	elseif typeX == "float4" then
		return clamp( x, float4(0), float4(1) )
	elseif typeX == "float3" then
		return clamp( x, float3(0), float3(1) )
	elseif typeX == "float2" then
		return clamp( x, float2(0), float2(1) )
	end
end

function floor( x )
	local typeX = type(x)
	local mathfunc = math.floor
	if x == nil then
		assert(false, "Can't eval floor for type '" .. typeX .. "'" )
	elseif typeX == "number" then
		return mathfunc( x )
	elseif typeX == "float4" then
		return float4( mathfunc( x.x ), mathfunc( x.y ), mathfunc( x.z ), mathfunc( x.w ) )
	elseif typeX == "float3" then
		return float3( mathfunc( x.x ), mathfunc( x.y ), mathfunc( x.z ) )
	elseif typeX == "float2" then
		return float2( mathfunc( x.x ), mathfunc( x.y ) )
	end
	assert(false, "Can't eval floor for type '" .. typeX .. "'" )
end

--added:
-- min, max, abs, acos, asin, atan, cos, sin, tan, ceil, clamp, saturate, floor

--to add:
--step, sqrt, rsqrt, smoothstep, round, sign, radians, degrees, distance, cross, dot, exp, exp2, fmod, length, log, log10, log2, modf, pow, normalize, trunc

--add?
--?refract, reflect, ddx, ddy