@echo off
setlocal enabledelayedexpansion
FOR /F "eol=# tokens=*" %%I IN (Settings.ini) do set %%I
chcp 1251>nul
if exist ~ER~ exit

Set tmpLog=%temp%\cfLoad.LOG
Set prmSt=DESIGNER %connSloc% /nmaster /p"%C1.password%" /LoadCfg _CFG_ /Out %tmpLog%
if NOT defined beg=%time%

if not exist _CFG_ (
	echo �� ��������� ���� ������������
	echo �� ��������� ���� ������������>>%Prt%
	2>nul echo "�� ��������� ���� ������������ ��� ��������">~ER~
	exit 2
)

if not exist %exe1c% (
	echo �� ��������� ���� ������� ��������� 1�: %exe1c%
	echo �� ��������� ���� ������� ��������� 1�: %exe1c%>>%Prt%
	2>nul echo "�� ��������� ���� ������� ��������� 1�: %exe1c%">~ER~
	exit 4
)

call deployka session kill %dpl% -lockuccode 0008 -lockstartat 0
timeout 1

echo %date% %time% �������� ������������ � %connSloc%
%exe1c% %prmSt% 
Set /a error=errorlevel
timeout 5
echo %date% %time% ��������� >> %tmpLog%

echo.&echo.&echo.&echo.&echo.&echo.

echo %esc%[35;40m===== %beg% ====%esc%[0;0m %esc%[93;40mLOG%esc%[0;0m %esc%[35;40m========================%esc%[90;40m
type %tmpLog%
echo %esc%[35;40m===== %time% ====%esc%[0;0m %esc%[93;40mEND%esc%[0;0m %esc%[35;40m========================%esc%[0;0m
echo.
if %error% NEQ 0 (
	type %tmpLog%>>%Prt%
	2>nul echo "��� �������� CF">~ER~
	type %tmpLog%>>~ER~
	)

