_type = type
type = function( v )
	local realType = _type( v )
	if realType == "table" then
		local meta = getmetatable( v )
		if meta ~= nil and meta.__type ~= nil then
			return meta.__type
		end
	end
	return realType
end



-- max = math.max
-- min = math.min
