float3meta = {
	__type = "float3",
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
				elseif op == "b" or op == "z" then
					res[i] = self.z
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
				elseif op == "b" or op == "z" then
					res[i] = self.z
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
				elseif op == "b" or op == "z" then
					res[i] = self.z
				end
			end
			return float2(res[1],res[2])
		elseif size == 1 then
			if key == "r"  or op == "x" then
				return self.x
			elseif key == "g" or op == "y" then
				return self.y
			elseif key == "b" or op == "z" then
				return self.z
			end
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
				elseif key == "b" or op == "z" then
					self.z = value
				else
					assert( false, "cannot implicitly convert from '" .. type(value) .. "' to '" .. type(self) .. "'" )
				end
			elseif valType == "float4" or valType == "float3" or valType == "float2" then
				if key == "r" or op == "x" then
					self.x = value.x
				elseif key == "g" or op == "y" then
					self.y = value.x
				elseif key == "b" or op == "z" then
					self.z = value.x
				else
					assert( false, "cannot implicitly convert from '" .. type(value) .. "' to '" .. type(self) .. "'" )
				end
			end
		elseif size == 3 then
			local valType = type(value)
			if valType == "number" then
				for i = 1, 3 do
					local op = string.sub(key, i, i)
					if op == "r" or op == "x" then
						self.x = value
					elseif op == "g" or op == "y" then
						self.y = value
					elseif op == "b" or op == "z" then
						self.z = value
					end
				end
			elseif valType == "float4" or valType == "float3" then
				local assignValues = { value.x, value.y, value.z }
				for i = 1, 3 do
					local op = string.sub(key, i, i)
					if op == "r" or op == "x" then
						self.x = assignValues[i]
					elseif op == "g" or op == "y" then
						self.y = assignValues[i]
					elseif op == "b" or op == "z" then
						self.z = assignValues[i]
					end
				end
			else
				assert( false, "cannot implicitly convert from '" .. type(value) .. "' to '" .. type(self) .. "'" )
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
					elseif op == "b" or op == "z" then
						self.z = value
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
					elseif op == "b" or op == "z" then
						self.z = assignValues[i]
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
			return float3( self.x + value, self.y + value, self.z + value )
		elseif valType == "float4" or valType == "float3" then
			return float3( self.x + value.x, self.y + value.y, self.z + value.z )
		elseif valType == "float2" then
			return float2( self.x + value.x, self.y + value.y )
		end
		assert(false, "Cannot add '" .. type(value) .. "' to '" .. type(self) .. "'" )
	end,
	__mul = function(self, value )
		local valType = type(value)
		if valType == "number" then
			return float3( self.x * value, self.y * value, self.z * value )
		elseif valType == "float4" or valType == "float3" then
			return float3( self.x * value.x, self.y * value.y, self.z * value.z )
		elseif valType == "float2" then
			return float2( self.x * value.x, self.y * value.y )
		end
		assert(false, "Cannot mul '" .. type(value) .. "' to '" .. type(self) .. "'" )
	end,
	__sub = function(self, value )
		local valType = type(value)
		if valType == "number" then
			return float3( self.x - value, self.y - value, self.z - value )
		elseif valType == "float4" or valType == "float3" then
			return float3( self.x - value.x, self.y - value.y, self.z - value.z )
		elseif valType == "float2" then
			return float2( self.x - value.x, self.y - value.y )
		end
		assert(false, "Cannot sub '" .. type(value) .. "' to '" .. type(self) .. "'" )
	end,
	__div = function(self, value )
		local valType = type(value)
		if valType == "number" then
			return float3( self.x / value, self.y / value, self.z / value )
		elseif valType == "float4" or valType == "float3" then
			return float3( self.x / value.x, self.y / value.y, self.z / value.z )
		elseif valType == "float2" then
			return float2( self.x / value.x, self.y / value.y )
		end
		assert(false, "Cannot div '" .. type(value) .. "' to '" .. type(self) .. "'" )
	end,
	__tostring = function( self )
		return "float3("..self.x..","..self.y..","..self.z..")"
	end,
}


float3 = function( x, y, z )
	--if data == nil then
	local data = {}
	if type(x) == "number" and type(y) == "number" and type(z) == "number" then
		data = { ["x"] = x, ["y"] = y, ["z"] = z }
	elseif type(x) == "float3" and y == nil and z == nil then
		data = { ["x"] = x.x, ["y"] = x.y, ["z"] = x.z }
	elseif type(x) == "float2" and type(y) == "number" and z == nil then
		data = { ["x"] = x.x, ["y"] = x.y, ["z"] = y }
	elseif type(x) == "number" and type(y) == "float2" and z == nil then
		data = { ["x"] = x, ["y"] = y.x, ["z"] = y.y }
	else
		local args = "Can't construct 'float3' " .. " from:"
		--TODO remade to table
		if x ~= nil then
			args = args .. " '" .. type(x) .. "'"
		end
		if y ~= nil then
			args = args .. "'" .. type(y) .. "'"
		end
		if z ~= nil then
			args = args .. "'" .. type(z) .. "'"
		end
		assert(false, args)
		return nil
	end
	setmetatable( data, float3meta )

	return data
end
