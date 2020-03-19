@echo off
setlocal enabledelayedexpansion
FOR /F "eol=# tokens=*" %%I IN (Settings.ini) do set %%I
chcp 1251>nul
Set vb=vb.vbs
Set out=j.json



if defined notify.err.only if exist ~OK~ exit

if NOT exist %Prt% exit

@for /f "usebackq" %%S in (`find /c /v ""^<"%Prt% "`) do @(set /a NumStr=%%S) 

if %NumStr% LSS 2 ( exit )


For /F "delims=" %%i In (%Prt%) Do @if NOT z%%i==z Set txt=!txt!#%%i

call :createVBS %vb%
copy %Prt% %temp%\prt.txt>nul
call %vb% ^
	/mailto:"VSukhikh@gmail.com"^
        /Subject:"%date% обновление mc_bnu_oru"^
        /BodyText:"%txt:#=<li>%"^
	/Attach:%temp%\prt.txt
@echo ######### ERROR: %errorlevel% ##########
del %vb%



chcp 65001>nul
@Set txt=%txt:{=(%
@Set txt=%txt:}=)%
@Set txt=%txt:\=\\%
echo {"value1": "%txt:#=<br><li> %"} >%out%


if exist %out% (
	curl -X POST -H "Content-Type: application/json" -d @%out% "https://maker.ifttt.com/trigger/OBRrefreshing/with/key/cd7VHzgV9MijmevbaKNDEx"
)
@echo. & @echo ######### ERROR: %errorlevel% ##########
exit /b
:createVBS
2>nul md>%1
@echo Dim OutLookApp		>>%1
@echo Dim OutLookItem		>>%1
@echo On Error Resume Next	>>%1
@echo Set OutLookApp = GetObject(, "Outlook.Application") >>%1
@echo Set OutLookApp = CreateObject("Outlook.Application")>>%1
@echo Set objNamedArgs = WScript.Arguments.Named          >>%1
@echo Set OutLookItem = OutLookApp.CreateItem(0)          >>%1
@echo With OutLookItem                                    >>%1
@echo     .Subject = objNamedArgs.Item("Subject")         >>%1
@echo     .to = objNamedArgs.Item("MailTo")      	  >>%1
@echo     .HtmlBody = objNamedArgs.Item("BodyText")       >>%1
@echo     .Attachments.Add objNamedArgs.Item("Attach")    >>%1
@echo     .Display                                        >>%1
@echo     .Send                                           >>%1
@echo End With                                            >>%1


exit /b
