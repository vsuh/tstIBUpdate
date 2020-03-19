@echo off
setlocal enabledelayedexpansion
FOR /F "eol=# tokens=*" %%I IN (Settings.ini) do set %%I
chcp 1251>nul
if exist ~ER~ exit

@echo %date% %time% {%~nx0} загрузка CF в локальную ИБ >>%Prt%
Set tmpLog=%temp%\cfLoad.LOG
Set prmSt=DESIGNER %connSloc% /nmaster /p"%C1.password%" /LoadCfg _CFG_ /Out %tmpLog%
if NOT defined beg=%time%

if not exist _CFG_ (
	echo не обнаружен файл конфигурации
	echo не обнаружен файл конфигурации>>%Prt%
	2>nul echo 	{%~nx0} не обнаружен файл конфигурации для загрузки >~ER~
	exit 2
)

if not exist %exe1c% (
	echo не обнаружен файл запуска платформы 1С: %exe1c%
	echo не обнаружен файл запуска платформы 1С: %exe1c%>>%Prt%
	2>nul echo 	{%~nx0} не обнаружен файл запуска платформы 1С: %exe1c% >~ER~
	exit 4
)

call deployka session kill %dpl% -lockuccode 0008 -lockstartat 0
timeout 1 >nul

echo %date% %time% загрузка конфигурации в %connSloc%
%exe1c% %prmSt% 
Set /a error=errorlevel
timeout 5 >nul
echo %date% %time% Завершено >> %tmpLog%

echo.&echo.&echo.&echo.&echo.&echo.

echo %esc%[35;40m===== %beg% ====%esc%[0;0m %esc%[93;40mLOG%esc%[0;0m %esc%[35;40m========================%esc%[90;40m
type %tmpLog%
echo %esc%[35;40m===== %time% ====%esc%[0;0m %esc%[93;40mEND%esc%[0;0m %esc%[35;40m========================%esc%[0;0m
echo.
::---------------
::@for /f "usebackq" %%S in (`find /c /v ""^<"%tmpLog% "`) do @(set /a NumStr=%%S) 
::echo в файле %tmpLog% %NumStr% строк >>%Prt%
::---------------


if %error% NEQ 0 (
	type %tmpLog%>>%Prt%
	2>nul echo %date% %time% {%~nx0} при загрузке CF >~ER~
	type %tmpLog%>>~ER~
	)

