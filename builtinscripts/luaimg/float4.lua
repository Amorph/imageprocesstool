float4meta = {
	__type = "float4",
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
				elseif op == "a" or op == "w"then
					res[i] = self.w
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
				elseif op == "a" or op == "w" then
					res[i] = self.w
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
				elseif op == "a" or op == "w" then
					res[i] = self.w
				end
			end
			return float2(res[1],res[2])
		elseif size == 1 then
			if key == "r" or op == "x" then
				return self.x
			elseif key == "g" or op == "y" then
				return self.y
			elseif key == "b" or op == "z" then
				return self.z
			elseif key == "a" or op == "w" then
				return self.w
			end
		end
		return nil
    end,
	__newindex = function( self, key, value )
		local size = string.len(key)
		if size == 1 then
			local valType = typeex(value)
			if valType == "number" then
				if key == "r" or op == "x" then
					self.x = value
				elseif key == "g" or op == "y" then
					self.y = value
				elseif key == "b" or op == "z" then
					self.z = value
				elseif key == "a" or op == "w" then
					self.w = value
				else
					assert( false, "cannot implicitly convert from '" .. typeex(value) .. "' to '" .. typeex(self) .. "'" )
				end
			elseif valType == "float4" or valType == "float3" or valType == "float2" then
				if key == "r" or op == "x" then
					self.x = value.x
				elseif key == "g" or op == "y" then
					self.y = value.x
				elseif key == "b" or op == "z" then
					self.z = value.x
				elseif key == "a" or op == "w" then
					self.w = value.x
				else
					assert( false, "cannot implicitly convert from '" .. typeex(value) .. "' to '" .. typeex(self) .. "'" )
				end
			end
		elseif size == 4 then
			local valType = typeex(value)
			if valType == "number" then
				for i = 1, 4 do
					local op = string.sub(key, i, i)
					if op == "r" or op == "x" then
						self.x = value
					elseif op == "g" or op == "y" then
						self.y = value
					elseif op == "b" or op == "z" then
						self.z = value
					elseif op == "a" or op == "w" then
						self.w = value
					end
				end
			elseif valType == "float4" then
				local assignValues = { value.x, value.y, value.z, value.w }
				for i = 1, 4 do
					local op = string.sub(key, i, i)
					if op == "r" or op == "x" then
						self.x = assignValues[i]
					elseif op == "g" or op == "y" then
						self.y = assignValues[i]
					elseif op == "b" or op == "z" then
						self.z = assignValues[i]
					elseif op == "a" or op == "w" then
						self.w = assignValues[i]
					end
				end
			else
				assert( false, "cannot implicitly convert from '" .. typeex(value) .. "' to '" .. typeex(self) .. "'" )
			end
		elseif size == 3 then
			local valType = typeex(value)
			if valType == "number" then
				for i = 1, 3 do
					local op = string.sub(key, i, i)
					if op == "r" or op == "x" then
						self.x = value
					elseif op == "g" or op == "y" then
						self.y = value
					elseif op == "b" or op == "z" then
						self.z = value
					elseif op == "a" or op == "w" then
						self.w = value
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
					elseif op == "a" or op == "w" then
						self.w = assignValues[i]
					end
				end
			else
				assert( false, "cannot implicitly convert from '" .. typeex(value) .. "' to '" .. typeex(self) .. "'" )
			end
		elseif size == 2 then
			local valType = typeex(value)
			if valType == "number" then
				for i = 1, 2 do
					local op = string.sub(key, i, i)
					if op == "r" or op == "x" then
						self.x = value
					elseif op == "g" or op == "y" then
						self.y = value
					elseif op == "b" or op == "z" then
						self.z = value
					elseif op == "a" or op == "w" then
						self.w = value
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
					elseif op == "a" or op == "w" then
						self.w = assignValues[i]
					end
				end
			else
				assert( false, "cannot implicitly convert from '" .. typeex(value) .. "' to '" .. typeex(self) .. "'" )
			end
		end
	end,
	__add = function(self, value )
		local valType = typeex(value)
		if valType == "number" then
			return float4( self.x + value, self.y + value, self.z + value, self.w + value )
		elseif valType == "float4" then
			return float4( self.x + value.x, self.y + value.y, self.z + value.z, self.w + value.w )
		elseif valType == "float3" then
			return float3( self.x + value.x, self.y + value.y, self.z + value.z )
		elseif valType == "float2" then
			return float2( self.x + value.x, self.y + value.y )
		end
		assert(false, "Cannot add '" .. typeex(value) .. "' to '" .. typeex(self) .. "'" )
	end,
	__mul = function(self, value )
		local valType = typeex(value)
		if valType == "number" then
			return float4( self.x * value, self.y * value, self.z * value, self.w * value )
		elseif valType == "float4" then
			return float4( self.x * value.x, self.y * value.y, self.z * value.z, self.w * value.w )
		elseif valType == "float3" then
			return float3( self.x * value.x, self.y * value.y, self.z * value.z )
		elseif valType == "float2" then
			return float2( self.x * value.x, self.y * value.y )
		end
		assert(false, "Cannot mul '" .. typeex(value) .. "' to '" .. typeex(self) .. "'" )
	end,
	__sub = function(self, value )
		local valType = typeex(value)
		if valType == "number" then
			return float4( self.x - value, self.y - value, self.z - value, self.w - value )
		elseif valType == "float4" then
			return float4( self.x - value.x, self.y - value.y, self.z - value.z, self.w - value.w )
		elseif valType == "float3" then
			return float3( self.x - value.x, self.y - value.y, self.z - value.z )
		elseif valType == "float2" then
			return float2( self.x - value.x, self.y - value.y )
		end
		assert(false, "Cannot sub '" .. typeex(value) .. "' to '" .. typeex(self) .. "'" )
	end,
	__div = function(self, value )
		local valType = typeex(value)
		if valType == "number" then
			return float4( self.x / value, self.y / value, self.z / value, self.w / value )
		elseif valType == "float4" then
			return float4( self.x / value.x, self.y / value.y, self.z / value.z, self.w / value.w )
		elseif valType == "float3" then
			return float3( self.x / value.x, self.y / value.y, self.z / value.z )
		elseif valType == "float2" then
			return float2( self.x / value.x, self.y / value.y )
		end
		assert(false, "Cannot div '" .. typeex(value) .. "' to '" .. typeex(self) .. "'" )
	end,
	__tostring = function( self )
		return "float4("..self.x..","..self.y..","..self.z..","..self.w..")"
	end,
}


float4 = function( x, y, z, w )
	--if data == nil then
	local data = {}
	if typeex(x) == "number" and typeex(y) == "number" and typeex(z) == "number" and typeex(w) == "number" then
		data = { ["x"] = x, ["y"] = y, ["z"] = z, ["w"] = w }
	elseif typeex(x) == "float4" and y == nil and z == nil and w == nil then
		data = { ["x"] = x.x, ["y"] = x.y, ["z"] = x.z, ["w"] = x.w }
	elseif typeex(x) == "float3" and typeex(y) == "number" and z == nil and w == nil then
		data = { ["x"] = x.x, ["y"] = x.y, ["z"] = x.z, ["w"] = y }
	elseif typeex(x) == "number" and typeex(y) == "float3" and z == nil and w == nil then
		data = { ["x"] = x, ["y"] = y.x, ["z"] = y.y, ["w"] = y.z }
	elseif typeex(x) == "float2" and typeex(y) == "float2" and z == nil and w == nil then
		data = { ["x"] = x.x, ["y"] = x.y, ["z"] = y.x, ["w"] = y.y }
	elseif typeex(x) == "float2" and typeex(y) == "number" and typeex(z) == "number" and w == nil then
		data = { ["x"] = x.x, ["y"] = x.y, ["z"] = y, ["w"] = z }
	elseif typeex(x) == "number" and typeex(y) == "float2" and typeex(z) == "number" and w == nil then
		data = { ["x"] = x, ["y"] = y.x, ["z"] = y.y, ["w"] = z }
	elseif typeex(x) == "number" and typeex(y) == "number" and typeex(z) == "float2" and w == nil then
		data = { ["x"] = x, ["y"] = y, ["z"] = z.x, ["w"] = z.y }
	elseif typeex(x) == "number" and y == nil and z == nil and w == nil then
		data = { ["x"] = x, ["y"] = x, ["z"] = x, ["w"] = x }
	else

		local args = "Can't construct 'float4' " .. " from:"
		--TODO remade to table
		if x ~= nil then
			args = args .. " '" .. typeex(x) .. "'"
		end
		if y ~= nil then
			args = args .. "'" .. typeex(y) .. "'"
		end
		if z ~= nil then
			args = args .. "'" .. typeex(z) .. "'"
		end
		if w ~= nil then
			args = args .. "'" .. typeex(w) .. "'"
		end
		assert(false, args)
		return nil
	end
	setmetatable( data, float4meta )

	return data
end
