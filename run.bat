@echo on
setlocal enabledelayedexpansion
FOR /F "eol=# tokens=*" %%I IN (Settings.ini) do set %%I
chcp 1251>nul
Set exit=

for %%I in (??_*.cmd) do (
	@echo %date% %time% %%~nxI
	call %%I   

	if exist ~ER~ (
		@echo %DATE% %TIME% flag exit defined
		call finish.cmd
		@exit
	)
	@echo %DATE% %TIME% ^>^>^> [%errorlevel%] �������� ������� %%I
	timeout /t 5
	) 


:: todo: ���������� ������ � ��������
