::**************************************************************************
:: %1 - ProjectDir
::**************************************************************************
cd %1
cd ..
cd obj
if exist "../include/scripts.h" del "../include/scripts.h"
if not exist "../include" md "../include"
@for /r %%i in (*.h) do type %%i >> "../include/scripts.h"
