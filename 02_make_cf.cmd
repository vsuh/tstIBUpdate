@echo off
:: ���� �������� �������� kill - ������ �� ��������� �� ����� ��������
::
setlocal enabledelayedexpansion
FOR /F "eol=# tokens=*" %%I IN (Settings.ini) do set %%I
chcp 1251>nul

if exist ~ER~ exit

@echo %date% %time% {%~nx0} �������� CF ����� �� ��������� �� >>%Prt%
Set tmpLog=%temp%\cfDumping.log
Set prmSt=DESIGNER %connSoru% /nmaster /p"%C1.password%" /DumpCfg _CFG_ /Out %tmpLog%

if NOT defined beg=%time%

if not exist %exe1c% (
	echo �� ��������� ���� ������� ��������� 1�: %exe1c%
	echo �� ��������� ���� ������� ��������� 1�: %exe1c%>>%Prt%
	2>nul echo 	{%~nx0} �� ��������� ���� ������� ��������� 1�: %exe1c% >~ER~
	exit 4
)

:: ����� 7:00 ������ �� ���������
Set /a h=%time:~0,2% + 1
if %h% LSS 8    CALL deployka session kill %dpl% -lockuccode 0008 -with-nolock yes
if .%1.==.kill. CALL deployka session kill %dpl% -lockuccode 0008 -with-nolock yes
echo %date% %time% �������� ������������ �� %connSoru%
                echo %exe1c% %prmSt% 
%exe1c% %prmSt% 

Set /a error=errorlevel
timeout 5 >nul
CALL deployka session unlock %dpl% -lockuccode 0008
echo %date% %time% ��������� >> %tmpLog%

::cls&
echo.&echo.&echo.&echo.&echo.&echo.

echo %esc%[35;40m===== %beg% ====%esc%[0;0m %esc%[93;40mLOG%esc%[0;0m %esc%[35;40m========================%esc%[90;40m
type %tmpLog%
echo %esc%[35;40m===== %time% ====%esc%[0;0m %esc%[93;40mEND%esc%[0;0m %esc%[35;40m========================%esc%[0;0m
::---------------
::@for /f "usebackq" %%S in (`find /c /v ""^<"%tmpLog% "`) do @(set /a NumStr=%%S) 
::echo � ����� %tmpLog% %NumStr% ����� >>%Prt%
::---------------

echo.
if %error% NEQ 0 (
	type %tmpLog%>>%Prt%
	2>nul echo %date% %time% {%~nx0} �������� CF ����� >~ER~
	type %tmpLog%>>~ER~
	)

