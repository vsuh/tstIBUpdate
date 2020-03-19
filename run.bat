@echo off
setlocal enabledelayedexpansion
FOR /F "eol=# tokens=*" %%I IN (Settings.ini) do set %%I
chcp 1251>nul
Set /a resumefrom=0%1
for %%I in (??_*.cmd) do (
	for /F "delims=_ tokens=1,*" %%A in ("%%I") do Set /a Num=%%A
	if !Num! GEQ %resumefrom% (

		@echo %date% %time% %%~nxI
		call %%I   

		if exist ~ER~ (
			@echo %DATE% %TIME% flag exit defined
			call finish.cmd
			@exit
		)
		@echo %DATE% %TIME% ^>^>^> [%errorlevel%] Выполнен батфайл %%~nxI
	>nul timeout /t 5 
	)
) 

if defined notify.err.only (
	if exist ~ER~ call finish.cmd
) ELSE (
	call finish.cmd
	)
