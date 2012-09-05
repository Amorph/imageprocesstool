::**************************************************************************
:: %1% - ProjectDir
:: %2% - SafeParentName
:: %3% - InputName
:: %4% - InputFileName
::**************************************************************************
cd %1%
if not exist ..\obj\luaimg md ..\obj\luaimg

cd ..
::"%1\..\..\depend\luac\luac.exe" -o "obj/%2/%3.luac" %2/%4
::echo. > NUL 2>"obj/rebuild_header"
::cd obj
"%1\..\..\depend\luac\bin2c.exe" "%2/%4" > "obj/%2/%3.h"
