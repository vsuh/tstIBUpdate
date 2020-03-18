@echo off
setlocal enabledelayedexpansion
FOR /F "eol=# tokens=*" %%I IN (Settings.ini) do set %%I
chcp 1251>nul

Set tmpLog=%temp%\LOG.LOG
Set connS=/IBConnectionString File=D:\bases\KUCY;
Set prmSt=DESIGNER %connS% /nmaster /p"%C1.password%" /UpdateDBCfg /Out %tmpLog%
if NOT defined beg=%time%


if not exist %exe1c% (
	echo не обнаружен файл запуска платформы 1С: %exe1c%
	echo не обнаружен файл запуска платформы 1С: %exe1c%>>%Prt%
	2>nul echo "не обнаружен файл запуска платформы 1С: %exe1c%">~ER~
	exit 4
)
timeout 1
%exe1c% %prmSt% 
Set /a error=errorlevel
timeout 5
echo %date% %time% Завершено >> %tmpLog%

echo.&echo.&echo.&echo.&echo.&echo.

echo %esc%[35;40m===== %beg% ====%esc%[0;0m %esc%[93;40mLOG%esc%[0;0m %esc%[35;40m========================%esc%[90;40m
type %tmpLog%
echo %esc%[35;40m===== %time% ====%esc%[0;0m %esc%[93;40mEND%esc%[0;0m %esc%[35;40m========================%esc%[0;0m
echo.
if %error% NEQ 0 (
	type %tmpLog%>>%Prt%
	2>nul echo "при обновлении конфигурации">~ER~
	type %tmpLog%>>~ER~
	)

