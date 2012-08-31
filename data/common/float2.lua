
float2meta = {
	__type = "float2",
    __index= function( self, key )
		local size = string.len(key)
		if size == 4 then
			local res = {}
			for i = 1, 4 do
				local op = string.sub(key, i, i)
				if op == "r" or op == "x" then
					res[i] = self.x
				elseif op == "g" or op == "y" then
					res[i] = self.y
				else
					assert( false, "Unknown operand '" .. op .. "'" )
				end
			end
			return float4(res[1],res[2],res[3],res[4])
		elseif size == 3 then
			local res = {}
			for i = 1, 3 do
				local op = string.sub(key, i, i)
				if op == "r" or op == "x" then
					res[i] = self.x
				elseif op == "g" or op == "y" then
					res[i] = self.y
				else
					assert( false, "Unknown operand '" .. op .. "'" )
				end
			end
			return float3(res[1],res[2],res[3])
		elseif size == 2 then
			local res = {}
			for i = 1, 2 do
				local op = string.sub(key, i, i)
				if op == "r" or op == "x" then
					res[i] = self.x
				elseif op == "g" or op == "y" then
					res[i] = self.y
				else
					assert( false, "Unknown operand '" .. op .. "'" )
				end
			end
			return float2(res[1],res[2])
		end
		return nil
    end,
	__newindex = function( self, key, value )
		local size = string.len(key)
		if size == 1 then
			local valType = type(value)
			if valType == "number" then
				if key == "r" or op == "x" then
					self.x = value
				elseif key == "g" or op == "y" then
					self.y = value
				else
					assert( false, "cannot implicitly convert from '" .. type(value) .. "' to '" .. type(self) .. "'" )
				end
			elseif valType == "float4" or valType == "float3" or valType == "float2" then
				if key == "r" or op == "x" then
					self.x = value.x
				elseif key == "g" or op == "y" then
					self.y = value.x
				else
					assert( false, "cannot implicitly convert from '" .. type(value) .. "' to '" .. type(self) .. "'" )
				end
			end
		elseif size == 2 then
			local valType = type(value)
			if valType == "number" then
				for i = 1, 2 do
					local op = string.sub(key, i, i)
					if op == "r" or op == "x" then
						self.x = value
					elseif op == "g" or op == "y" then
						self.y = value
					end
				end
			elseif valType == "float4" or valType == "float3" or valType == "float2" then
				local assignValues = { value.x, value.y }
				for i = 1, 2 do
					local op = string.sub(key, i, i)
					if op == "r" or op == "x" then
						self.x = assignValues[i]
					elseif op == "g" or op == "y" then
						self.y = assignValues[i]
					end
				end
			else
				assert( false, "cannot implicitly convert from '" .. type(value) .. "' to '" .. type(self) .. "'" )
			end
		end
	end,
	__add = function(self, value )
		local valType = type(value)
		if valType == "number" then
			return float2( self.x + value, self.y + value )
		elseif valType == "float4" or valType == "float3" or valType == "float2" then
			return float2( self.x + value.x, self.y + value.y )
		end
		assert(false, "Cannot add '" .. type(value) .. "' to '" .. type(self) .. "'" )
	end,
	__mul = function(self, value )
		local valType = type(value)
		if valType == "number" then
			return float2( self.x * value, self.y * value )
		elseif valType == "float4" or valType == "float3" or valType == "float2" then
			return float2( self.x * value.x, self.y * value.y )
		end
		assert(false, "Cannot mul '" .. type(value) .. "' to '" .. type(self) .. "'" )
	end,
	__sub = function(self, value )
		local valType = type(value)
		if valType == "number" then
			return float2( self.x - value, self.y - value )
		elseif valType == "float4" or valType == "float3" or valType == "float2" then
			return float2( self.x - value.x, self.y - value.y )
		end
		assert(false, "Cannot sub '" .. type(value) .. "' to '" .. type(self) .. "'" )
	end,
	__div = function(self, value )
		local valType = type(value)
		if valType == "number" then
			return float2( self.x / value, self.y / value )
		elseif valType == "float4" or valType == "float3" or valType == "float2" then
			return float2( self.x / value.x, self.y / value.y )
		end
		assert(false, "Cannot div '" .. type(value) .. "' to '" .. type(self) .. "'" )
	end,
	__tostring = function( self )
		return "float2("..self.x..","..self.y..")"
	end,
}


float2 = function( x, y )
	--if data == nil then
	local data = {}
	if type(x) == "number" and type(y) == "number" then
		data = { ["x"] = x, ["y"] = y }
	elseif type(x) == "float2" and y == nil then
		data = { ["x"] = x.x, ["y"] = x.y }
	else
		local args = "Can't construct 'float2' " .. " from:"
		--TODO remade to table
		if x ~= nil then
			args = args .. " '" .. type(x) .. "'"
		end
		if y ~= nil then
			args = args .. "'" .. type(y) .. "'"
		end
		assert(false, args)
		return nil
	end
	setmetatable( data, float2meta )

	return data
end
