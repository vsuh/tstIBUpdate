@echo off
setlocal enabledelayedexpansion
FOR /F "eol=# tokens=*" %%I IN (Settings.ini) do set %%I
chcp 1251>nul
if exist ~ER~ exit

@echo %date% %time% {%~nx0} применение конфигурации в локальной ИБ >>%Prt%
Set tmpLog=%temp%\LOG.LOG
Set prmSt=DESIGNER %connSloc% /nmaster /p"%C1.password%" /UpdateDBCfg /Out %tmpLog%
if NOT defined beg=%time%


if not exist %exe1c% (
	echo не обнаружен файл запуска платформы 1С: %exe1c%
	echo не обнаружен файл запуска платформы 1С: %exe1c%>>%Prt%
	2>nul echo 	{%~nx0} не обнаружен файл запуска платформы 1С: %exe1c% >~ER~
	exit 4
)
timeout 1 >nul

echo %date% %time% принятие изменений конфигурации в %connSloc%
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
	2>nul echo %date% %time% {%~nx0} при применении конфигурации >~ER~
	type %tmpLog%>>~ER~
	)

