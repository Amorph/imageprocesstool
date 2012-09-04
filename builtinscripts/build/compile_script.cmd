::**************************************************************************
:: %1% - ProjectDir
:: %2% - SafeParentName
:: %3% - InputName
:: %4% - InputFileName
::**************************************************************************
cd %1%
cd ..
"%1\..\..\depend\luac\luac.exe" -o "obj/%2/%3.luac" %2/%4
echo. > NUL 2>"obj/rebuild_header"
cd obj
"%1\..\..\depend\luac\bin2c.exe" "%2/%3.luac" > "%2/%3.h"
::if not exist "scripts.h" echo /**/ > "scripts.h"
::copy "scripts.h" + "%3.h" "tmp.h" > nul
::del /F "%3.h"
::copy /Y "tmp.h" "scripts.h" > nul
::del /F "tmp.h" > nul
::cd %1%