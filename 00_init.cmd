@echo off
setlocal enabledelayedexpansion
FOR /F "eol=# tokens=*" %%I IN (Settings.ini) do set %%I
chcp 1251>nul

@echo %date% %time% {%~nx0} ������������� >>%Prt%
cd /d %~d0 || echo 	{%~nx0} �� ������� ������� ������� �� %~d0 >~ER~
del *.dt    >nul 2>&1
del _CFG_   >nul 2>&1
del ~OK~    >nul 2>&1
del ~ER~    >nul 2>&1
del PRT.ERR >nul 2>&1
echo %DATE% %TIME% [���������� �� MC_BNU_ORU](https://github.com/vsuh/tstIBUpdate.git) >>%Prt%
@for %%I in (%dtStore%\*.dt) do (
	@Set dt=%%I
	@Set /a sz=%%~zI /1024 / 1024

echo %date% %time% ����������� %dt% � bnu.dt �������� %sz% Mb.
copy %dt% bnu.dt || echo 	{%~nx0} copy %dt% (%sz% Mb.) to .\bnu.dt >~ER~

ovm r stable deployka info %dpl%>%temp%\check-rac.txt
find /i "������" %temp%\check-rac.txt>nul
if .%errorlevel%.==.0. (
	chcp 1251>nul
	type %temp%\check-rac.txt>>%Prt%
        2>nul echo 	{%~nx0} ��� �������� deployka >~ER~
)

taskkill /t /f /im 1cv8.exe