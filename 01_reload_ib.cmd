@echo off
setlocal enabledelayedexpansion
FOR /F "eol=# tokens=*" %%I IN (Settings.ini) do set %%I
chcp 1251>nul

@for %%I in (*.dt) do @Set dt=%%I
Set connS=/IBConnectionString File=D:\bases\KUCY;
Set prmSt=DESIGNER %connS% /nmaster /p"%C1.password%" /RestoreIB %dt% /Out %Log%
Set Log=%temp%\LOG.LOG
if NOT defined beg=%time%


if ^[%dt%^]==^[^] (
	echo ��������� �������� - dt ���� �������� ��
	echo ��������� �������� - dt ���� �������� ��>>%Prt%
	2>nul echo "�� ������ %dt%">~ER~
	exit 3
)

if not exist %exe1c% (
	echo �� ��������� ���� ������� ��������� 1�: %exe1c%
	echo �� ��������� ���� ������� ��������� 1�: %exe1c%>>%Prt%
	2>nul echo "�� ������ exe %exe1c%">~ER~
	exit 4
)

echo %date% %time% ������ �������� %dt% > %Log%
echo %connS% >> %Log%
timeout 1


%exe1c% %prmSt% 

Set error=%errorlevel%
timeout 5
echo %date% %time% �������� ��������� >> %Log%

::cls&echo.&echo.&echo.&echo.&echo.&echo.&
chcp 866>nul
echo %esc%[35;40m===== %beg% ====%esc%[0;0m %esc%[93;40mLOG%esc%[0;0m %esc%[35;40m========================%esc%[90;40m
type %Log%
echo %esc%[35;40m===== %time% ====%esc%[0;0m %esc%[93;40mEND%esc%[0;0m %esc%[35;40m========================%esc%[0;0m
echo.
if NOT .%error%.==.. (
	type %Log%>>%Prt%
	2>nul echo "��� �������� DT">~ER~
	)
