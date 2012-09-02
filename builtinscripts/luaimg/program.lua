ProgramsList = {
}

ProgramMeta = {
}

PassMeta = {
}

OutputMeta = {
}


Program = function ( name )
	local programData = {}

	setmetatable( programData, ProgramMeta )

	return programData
end

Pass = function ()
	local passData = {}

	setmetatable( passData, PassMeta )

	return passData
end

Output = function ()
	local outputData = {}

	setmetatable( outputData, OutputMeta )

	return outputData
end

RegisterProgram = function ( program )
	table.insert( ProgramsList, program )
end
