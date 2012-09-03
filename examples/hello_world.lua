--Add bin path to lib search path
package.cpath = "../bin/?.dll;"..package.cpath

require 'luaimg'


--imageprocesstool.exe must work with args in same way as lua.exe
print(arg[1])
print(arg[2])

