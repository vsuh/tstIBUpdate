@echo off
:: если передать параметр kill - сессии на серверной ИБ будут оборваны
::
setlocal enabledelayedexpansion
FOR /F "eol=# tokens=*" %%I IN (Settings.ini) do set %%I
chcp 1251>nul

if exist ~ER~ exit

@echo %date% %time% {%~nx0} выгрузка CF файла из серверной ИБ >>%Prt%
Set tmpLog=%temp%\cfDumping.log
Set prmSt=DESIGNER %connSoru% /nmaster /p"%C1.password%" /DumpCfg _CFG_ /Out %tmpLog%

if NOT defined beg=%time%

if not exist %exe1c% (
	echo не обнаружен файл запуска платформы 1С: %exe1c%
	echo не обнаружен файл запуска платформы 1С: %exe1c%>>%Prt%
	2>nul echo 	{%~nx0} не обнаружен файл запуска платформы 1С: %exe1c% >~ER~
	exit 4
)

:: после 7:00 сессии не отключать
Set /a h=%time:~0,2% + 1
if %h% LSS 8    CALL deployka session kill %dpl% -lockuccode 0008 -with-nolock yes
if .%1.==.kill. CALL deployka session kill %dpl% -lockuccode 0008 -with-nolock yes
echo %date% %time% выгрузка конфигурации из %connSoru%
                echo %exe1c% %prmSt% 
%exe1c% %prmSt% 

Set /a error=errorlevel
timeout 5 >nul
CALL deployka session unlock %dpl% -lockuccode 0008
echo %date% %time% Завершено >> %tmpLog%

::cls&
echo.&echo.&echo.&echo.&echo.&echo.

echo %esc%[35;40m===== %beg% ====%esc%[0;0m %esc%[93;40mLOG%esc%[0;0m %esc%[35;40m========================%esc%[90;40m
type %tmpLog%
echo %esc%[35;40m===== %time% ====%esc%[0;0m %esc%[93;40mEND%esc%[0;0m %esc%[35;40m========================%esc%[0;0m
::---------------
::@for /f "usebackq" %%S in (`find /c /v ""^<"%tmpLog% "`) do @(set /a NumStr=%%S) 
::echo в файле %tmpLog% %NumStr% строк >>%Prt%
::---------------

echo.
if %error% NEQ 0 (
	type %tmpLog%>>%Prt%
	2>nul echo %date% %time% {%~nx0} создание CF файла >~ER~
	type %tmpLog%>>~ER~
	)

