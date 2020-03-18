@echo off
setlocal enabledelayedexpansion
FOR /F "eol=# tokens=*" %%I IN (Settings.ini) do set %%I
chcp 1251>nul

Set Log=%temp%\LOG.LOG
Set exe1c="d:\myProgramFiles\1cv8\8.3.12.1616\bin\1cv8.exe"
Set connS=/IBConnectionString Srvr=obr-app-13;Ref=mc_bnu_oru;
Set tmpLog=%temp%\cfDumping.log
Set prmSt=DESIGNER %connS% /nmaster /p"%C1.password%" /DumpCfg _CFG_ /Out %tmpLog%

if NOT defined beg=%time%

if not exist %exe1c% (
	echo не обнаружен файл запуска платформы 1С: %exe1c%
	echo не обнаружен файл запуска платформы 1С: %exe1c%>>%Prt%
	2>nul echo "не обнаружен файл запуска платформы 1С: %exe1c%">~ER~
	exit 4
)

:: после 7:00 сессии не отключать
Set /a h=%time:~0,2% + 1
if %h% LSS 8 CALL deployka session kill %dpl% -lockuccode 0008 -with-nolock yes
%exe1c% %prmSt% 

Set /a error=errorlevel
timeout 5
echo %date% %time% Завершено >> %Log%

::cls&
echo.&echo.&echo.&echo.&echo.&echo.

echo %esc%[35;40m===== %beg% ====%esc%[0;0m %esc%[93;40mLOG%esc%[0;0m %esc%[35;40m========================%esc%[90;40m
type %tmpLog%
echo %esc%[35;40m===== %time% ====%esc%[0;0m %esc%[93;40mEND%esc%[0;0m %esc%[35;40m========================%esc%[0;0m
echo.
if %error% NEQ 0 (
	type %tmpLog%>>%Prt%
	2>nul echo "создание CF файла (%0)">~ER~
	type %tmpLog%>>~ER~
	)

