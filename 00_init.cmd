@echo off
setlocal enabledelayedexpansion
FOR /F "eol=# tokens=*" %%I IN (Settings.ini) do set %%I
chcp 1251>nul

cd /d %~d0 || 2>nul md>~ER~
del *.dt    >nul 2>&1
del _CFG_   >nul 2>&1
del ~OK~    >nul 2>&1
del ~ER~    >nul 2>&1
del PRT.ERR >nul 2>&1
echo %DATE% %TIME% Обновление ИБ MC_BNU_ORU>%Prt%
@for %%I in (%dtStore%\*.dt) do @Set dt=%%I

copy %dt% bnu.dt || echo "copy %dt% to bnu.dt">~ER~

ovm r stable deployka info %dpl%>%temp%\check-rac.txt
find /i "ошибка" %temp%\check-rac.txt>nul
if .%errorlevel%.==.0. (
	chcp 1251>nul
	type %temp%\check-rac.txt>>%Prt%
        2>nul echo "при проверке deployka">~ER~
)
