@echo off
setlocal enabledelayedexpansion
FOR /F "eol=# tokens=*" %%I IN (Settings.ini) do set %%I
chcp 1251>nul

if exist ~ER~ exit
@echo %date% %time% {%~nx0} �������� DT ����� � ��������� �� >>%Prt%
@for %%I in (*.dt) do @Set dt=%%I

Set tmpLog=%temp%\dtloading.log
Set prmSt=DESIGNER %connSloc% /nmaster /p"%C1.password%" /RestoreIB %dt% /Out %tmpLog%
Set Log=%temp%\LOG.LOG
if NOT defined beg=%time%


if ^[%dt%^]==^[^] (
	echo ��������� �������� - dt ���� �������� ��
	echo ��������� �������� - dt ���� �������� ��>>%Prt%
	2>nul echo 	{%~nx0} �� ������ %dt% >~ER~
	exit 3
)

if not exist %exe1c% (
	echo �� ��������� ���� ������� ��������� 1�: %exe1c%
	echo �� ��������� ���� ������� ��������� 1�: %exe1c%>>%Prt%
	2>nul echo 	{%~nx0} �� ������ exe %exe1c% >~ER~
	exit 4
)

echo %date% %time% ������ �������� %dt% > %tmpLog%
echo %connSloc% >> %tmpLog%
timeout 1 >nul

echo %date% %time% �������� DT � %connSloc%
%exe1c% %prmSt% 

Set /a error=errorlevel
timeout 5 >nul
echo %date% %time% �������� ��������� >> %tmpLog%

::cls&echo.&echo.&echo.&echo.&echo.&echo.&
chcp 866>nul
echo %esc%[35;40m===== %beg% ====%esc%[0;0m %esc%[93;40mLOG%esc%[0;0m %esc%[35;40m========================%esc%[90;40m
type %tmpLog%
echo %esc%[35;40m===== %time% ====%esc%[0;0m %esc%[93;40mEND%esc%[0;0m %esc%[35;40m========================%esc%[0;0m
echo.
::---------------
::@for /f "usebackq" %%S in (`find /c /v ""^<"%tmpLog% "`) do @(set /a NumStr=%%S) 
::echo � ����� %tmpLog% %NumStr% ����� >>%Prt%
::---------------

if %error% NEQ 0 (
	type %tmpLog%>>%Prt%
	echo %date% %time% {%~nx0} ������ ��� �������� DT>~ER~
	type %tmpLog% >>~ER~
	)
