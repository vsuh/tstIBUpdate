@echo off
setlocal enabledelayedexpansion
FOR /F "eol=# tokens=*" %%I IN (Settings.ini) do set %%I
chcp 1251>nul

Set Log=%temp%\LOG.LOG
Set connS=/IBConnectionString File=D:\bases\KUCY;
Set prmSt=DESIGNER %connS% /nmaster /p"%C1.password%" /LoadCfg _CFG_ /Out %Log%
if NOT defined beg=%time%

if not exist _CFG_ (
	echo не обнаружен файл конфигурации
	echo не обнаружен файл конфигурации>>%Prt%
	2>nul echo "не обнаружен файл конфигурации для загрузки">~ER~
	exit 2
)

if not exist %exe1c% (
	echo не обнаружен файл запуска платформы 1С: %exe1c%
	echo не обнаружен файл запуска платформы 1С: %exe1c%>>%Prt%
	2>nul echo "не обнаружен файл запуска платформы 1С: %exe1c%">~ER~
	exit 4
)

call deployka session kill %dpl% -lockuccode 0008 -lockstartat 0
timeout 1
%exe1c% %prmSt% 
Set error=%errorlevel%
timeout 5
echo %date% %time% Завершено >> %Log%

echo.&echo.&echo.&echo.&echo.&echo.

echo %esc%[35;40m===== %beg% ====%esc%[0;0m %esc%[93;40mLOG%esc%[0;0m %esc%[35;40m========================%esc%[90;40m
type %Log%
echo %esc%[35;40m===== %time% ====%esc%[0;0m %esc%[93;40mEND%esc%[0;0m %esc%[35;40m========================%esc%[0;0m
echo.
if NOT .%error%.==.. (
	type %Log%>>%Prt%
	2>nul echo "при загрузке CF">~ER~
	)

