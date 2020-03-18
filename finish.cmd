@echo off
setlocal enabledelayedexpansion
FOR /F "eol=# tokens=*" %%I IN (Settings.ini) do set %%I
chcp 1251>nul
Set vb=vb.vbs
Set out=j.json

echo on
call :createVBS %vb%


if exist ~OK~ exit
if NOT exist %Prt% exit

@for /f "usebackq" %%S in (`find /c /v ""^<"%Prt% "`) do @(set /a NumStr=%%S) 

if %NumStr% LSS 2 ( exit )


Set txt=             

For /F "delims=" %%i In (%Prt%) Do @if NOT z%%i==z Set txt=!txt!^<li^>%%i


::Set txt="^^^<body^^^>^^^<ul^^^>!txt!^^^</ul^^^>^^^</body^^^>"

::Set txt=^<li^> first^<li^> second

copy %Prt% %temp%\prt.txt>nul
call %vb% ^
	/mailto:"VSukhikh@gmail.com"^
        /Subject:"%date% обновление mc_bnu_oru"^
        /BodyText:"%txt%"^
	/Attach:%temp%\prt.txt
chcp 65001>nul
echo {"value1": "%txt:#=<br>%"} >%out%

@echo ######### ERROR: %errorlevel% ##########
@echo -------------------------------
@echo "%txt%"
@echo -------------------------------
del %vb%

if exist %out% (
	curl -X POST -H "Content-Type: application/json" -d @j.json "https://maker.ifttt.com/trigger/OBRrefreshing/with/key/cd7VHzgV9MijmevbaKNDEx"
)
exit
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
