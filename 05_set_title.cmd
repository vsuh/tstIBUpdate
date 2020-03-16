@echo off
setlocal enabledelayedexpansion
FOR /F "eol=# tokens=*" %%I IN (Settings.ini) do set %%I
chcp 1251>nul
Set err=%temp%\setTitle.LOG
call deployka run /fKUCY^
	 -db-user master -db-pwd %C1.password%^
	 -uccode 0008^
	 -command "ЗаголовокСистемы;лок.Копия.ОРУ"^
	 -v8version "18.3.12.1616"^
	 -additional "/RunModeOrdinaryApplication /UsePrivilegedMode /DisableStartupMessages /DisableStartupDialogs /ClearCache /AllowExecuteScheduledJobs -Off"^
	 >%err%

if NOT .%errorlevel%.==.0. (
	type %err%>>%Prt% && del %err%
	) else (
	2>nul rd>~OK~
	)
