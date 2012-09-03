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
		luaimg.ExecProgram( program )
		programId, program = next( toExec, programId )
	end
end

luaimg.ExecProgram = function ( program )
	local passId, pass = nil, nil

	passId, pass = next( program.passes, passId )
	while( passId ~= nil ) do
		luaimg.ExecPass( pass )
		passId, pass = next( program.passes, passId )
	end

	local outputId, output = nil, nil

	outputId, output = next( program.output, outputId )
	while( outputId ~= nil ) do
		luaimg.ExecOutput( output )
		outputId, output = next( program.output, outputId )
	end

end

luaimg.ExecPass = function ( pass )
	local imgWidth = pass.target.width
	local imgHeight = pass.target.height
	local texelSizeX = 1 / pass.target.width
	local texelSizeY = 1 / pass.target.height
	local halfTexelSizeX = texelSizeX * 0.5
	local halfTexelSizeY = texelSizeY * 0.5


	for x = 0, imgWidth - 1 do
		local texX = halfTexelSizeX + x * texelSizeX
		for y = 0, imgHeight - 1 do
			local texY = halfTexelSizeY + y * texelSizeY
			local inputUV = nil
			if pass.mapping == PIXEL then
				inputUV = float2( x, y )
			else
				inputUV = float2( texX, texY )
			end
			setTex2D( pass.target, float2(x, y), pass.code( inputUV ) )
		end
	end
end

luaimg.ExecOutput = function ( output )
	SaveImage( output.texture, output.fileName )
end
