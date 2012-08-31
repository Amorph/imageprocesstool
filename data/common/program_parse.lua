require 'common/program'

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

		self.output.fileName= outParseData.fileName
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
			if meta == PassMeta then
				table.insert(self.program.passes,value)
			elseif meta == OutputMeta then
				table.insert(self.program.output,value)
			end
			it, value = next( programParseData, it )
		end

		RegisterProgram( self.program )
		return self.program
	end,
}



function pass(name)
	local passData=Pass()
	local passParseData={}

	if type(name) == "string" then
		passParseData.pass = passData
		passParseData.pass.name = name
		setmetatable( passParseData, passParseMeta )

		return passParseData
	elseif type(name) == "table" then
		passParseData.pass = passData
		passParseData.pass.name = "Unnamed"
		setmetatable( passParseData, passParseMeta )
		return passParseData( name )
	end
end


function output(name)
	local outputData=Output()
	local outputParseData={}

	if type(name) == "string" then
		outputParseData.output = outputData
		outputParseData.output.name = name
		setmetatable( outputParseData, outputParseMeta )

		return outputParseData
	elseif type(name) == "table" then
		outputParseData.output = outputData
		outputParseData.output.name = "Unnamed"
		setmetatable( outputParseData, outputParseMeta )
		return outputParseData( name )
	end
end


function program(name)
	assert(type(name) == "string","Program should be named")

	local programData = Program(name)
	local programParseData = {}

	programData.name = name
	programParseData.program = programData

	setmetatable( programParseData, programParseMeta )

	return programParseData
end
