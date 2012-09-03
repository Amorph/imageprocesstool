luaimg.ProgramsList = {
}

luaimg.ProgramMeta = {
}

luaimg.PassMeta = {
}

luaimg.OutputMeta = {
}


luaimg.Program = function ( name )
	local programData = {}

	setmetatable( programData, luaimg.ProgramMeta )

	return programData
end

luaimg.Pass = function ()
	local passData = {}

	setmetatable( passData, luaimg.PassMeta )

	return passData
end

luaimg.Output = function ()
	local outputData = {}

	setmetatable( outputData, luaimg.OutputMeta )

	return outputData
end

luaimg.RegisterProgram = function ( program )
	table.insert( luaimg.ProgramsList, program )
end

luaimg.Exec = function( programs )
	local toExec = nil
	if programs == nil then
		toExec = luaimg.ProgramsList
	elseif type(programs) == "string" then
		assert(false, "TODO: implement starting of specified program")
	elseif type(programs) == "table" then
		assert(false, "TODO: implement starting of list programs")
	end
	assert( toExec ~= nil, "Can't start program(s)" )



	local programId, program = nil, nil

	programId, program = next( toExec, programId )
	while( programId ~= nil ) do
		print( "Trying to execute program:" .. program.name )
		programId, program = next( toExec, programId )
	end
end
