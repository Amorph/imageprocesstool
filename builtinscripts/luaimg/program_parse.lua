
local passParseMeta=
{
	__call = function( self, passParseData )
		self.pass.target = passParseData.target
		self.pass.mapping = passParseData.mapping
		self.pass.code = passParseData.code

		return self.pass
	end,
}

local outputParseMeta=
{
	__call = function( self, outParseData )

		self.output.outFile= outParseData.outFile
		self.output.texture = outParseData.texture

		return self.output
	end,
}

local programParseMeta=
{
	__call = function( self, programParseData )
		self.program.passes = {}
		self.program.output = {}
		local it,value = nil, nil

		it, value = next(programParseData)
		while( it ~= nil ) do
			local meta = getmetatable( value )
			if meta == luaimg.PassMeta then
				table.insert(self.program.passes,value)
			elseif meta == luaimg.OutputMeta then
				table.insert(self.program.output,value)
			else
				assert( false, "Unknown type in program table" )
			end
			it, value = next( programParseData, it )
		end

		luaimg.RegisterProgram( self.program )
		return self.program
	end,
}



function pass(name)
	local passData=luaimg.Pass()
	local passParseData={}

	if typeex(name) == "string" then
		passParseData.pass = passData
		passParseData.pass.name = name
		setmetatable( passParseData, passParseMeta )

		return passParseData
	elseif typeex(name) == "table" then
		passParseData.pass = passData
		passParseData.pass.name = "Unnamed"
		setmetatable( passParseData, passParseMeta )
		return passParseData( name )
	end
end


function output(name)
	local outputData=luaimg.Output()
	local outputParseData={}

	if typeex(name) == "string" then
		outputParseData.output = outputData
		outputParseData.output.name = name
		setmetatable( outputParseData, outputParseMeta )

		return outputParseData
	elseif typeex(name) == "table" then
		outputParseData.output = outputData
		outputParseData.output.name = "Unnamed"
		setmetatable( outputParseData, outputParseMeta )
		return outputParseData( name )
	end
end


function program(name)
	assert(typeex(name) == "string","Program should be named")

	local programData = luaimg.Program(name)
	local programParseData = {}

	programData.name = name
	programParseData.program = programData

	setmetatable( programParseData, programParseMeta )

	return programParseData
end
