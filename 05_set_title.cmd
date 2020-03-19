@echo off
setlocal enabledelayedexpansion
FOR /F "eol=# tokens=*" %%I IN (Settings.ini) do set %%I
chcp 1251>nul
Set tmpLog=%temp%\LOG.LOG

@echo %date% %time% {%~nx0} установить заголовок >>%Prt%
if exist ~ER~ exit
Set err=%temp%\setTitle.LOG
call deployka run /fKUCY^
	 -db-user master -db-pwd %C1.password%^
	 -uccode 0008^
	 -command "ЗаголовокСистемы;лок.Копия.ОРУ"^
	 -v8version "8.3.12.1616"^
	 -additional "/RunModeOrdinaryApplication /UsePrivilegedMode /DisableStartupMessages /DisableStartupDialogs /ClearCache /AllowExecuteScheduledJobs -Off"^
	 >%tmpLog%

if %errorlevel% NEQ 0 (
	type {%~nx0} %tmpLog% >~ER~
	type %tmpLog%>>%Prt% && del %err%
) else (
	2>nul md>~OK~
)
