set RepertoireLog=C:\ProgramData\CtrlPc\TEMP\Install.log

echo %date% %time% : Contrôle version >> %RepertoireLog%
for /f "tokens=1 delims= " %%i in ( C:\ProgramData\CtrlPc\TEMP\version.txt ) do set version=%%i
IF %errorlevel% NEQ 0 ( GOTO BEGIN )
echo %date% %time% : Version MAJ : %version% >> %RepertoireLog%
for /f "tokens=3 delims= " %%i in ( '"REG QUERY HKEY_USERS\.DEFAULT\Software\CtrlPc\Version | find "Version"" ' ) do set VersionStation=%%i
echo %date% %time% : Version Station : %VersionStation% >> %RepertoireLog%
IF %Version%==%VersionStation% ( GOTO END ) ELSE ( GOTO BEGIN )

:BEGIN
echo %date% %time% : Création des répertoires >> %RepertoireLog%
echo %date% %time% : Création C:\ProgramData\CtrlPc >> %RepertoireLog%
MD C:\ProgramData\CtrlPc >> %RepertoireLog%
echo %date% %time% : Création C:\ProgramData\CtrlPc\INSTALLATION >> %RepertoireLog%
MD C:\ProgramData\CtrlPc\INSTALLATION >> %RepertoireLog%
echo %date% %time% : Création C:\ProgramData\CtrlPc\FLAG >> %RepertoireLog%
MD C:\ProgramData\CtrlPc\FLAG >> %RepertoireLog%
echo %date% %time% : Création C:\ProgramData\CtrlPc\LOG >> %RepertoireLog%
MD C:\ProgramData\CtrlPc\LOG >> %RepertoireLog%
echo %date% %time% : Création C:\ProgramData\CtrlPc\PLANNING >> %RepertoireLog%
MD C:\ProgramData\CtrlPc\PLANNING >> %RepertoireLog%
echo %date% %time% : Création C:\ProgramData\CtrlPc\SCRIPT >> %RepertoireLog%
MD C:\ProgramData\CtrlPc\SCRIPT >> %RepertoireLog%
echo %date% %time% : Création C:\ProgramData\CtrlPc\TEMP >> %RepertoireLog%
MD C:\ProgramData\CtrlPc\TEMP >> %RepertoireLog%
echo %date% %time% : Fin de création des répertoires >> %RepertoireLog%

echo %date% %time% : Contrôle présence du service >> %RepertoireLog%
sc query ServiceCtrlPc
IF %ERRORLEVEL% NEQ 0 ( GOTO CreateRep ) ELSE ( GOTO Stop )

:Stop
echo %date% %time% : Arrêt du service >> %RepertoireLog%
Net stop ServiceCtrlPc >> %RepertoireLog%
TIMEOUT /T 10 /NOBREAK
for /f "tokens=4 delims= " %%i in ( '"sc query ServiceCtrlPc | find "STATE"" ' ) do set StatutService=%%i
IF %StatutService%==STOPPED ( GOTO SupprService ) ELSE ( GOTO Kill )

:Kill
echo %date% %time% : Statut : %StatutService% >> %RepertoireLog%
echo %date% %time% : Kill du service >> %RepertoireLog%
taskkill /f /im ServiceCtrlPc.exe >> %RepertoireLog%
GOTO SupprService

:SupprService
echo %date% %time% : Statut : %StatutService% >> %RepertoireLog%
echo %date% %time% : Suppression du service >> %RepertoireLog%
sc delete ServiceCtrlPc >> %RepertoireLog%


:CreateRep
echo %date% %time% : Déplacement fichier >> %RepertoireLog%
echo %date% %time% : Déplacement fichier GeneLog.dll vers C:\ProgramData\CtrlPc\SCRIPT\GeneLog.dll >> %RepertoireLog%
copy .\GeneLog.dll C:\ProgramData\CtrlPc\SCRIPT\GeneLog.dll >> %RepertoireLog%
echo %date% %time% : Déplacement fichier TraceLog.exe vers C:\ProgramData\CtrlPc\SCRIPT\TraceLog.exe >> %RepertoireLog%
copy .\TraceLog.exe C:\ProgramData\CtrlPc\SCRIPT\TraceLog.exe >> %RepertoireLog%
echo %date% %time% : Déplacement fichier ServiceCtrlPc.exe vers C:\ProgramData\CtrlPc\INSTALLATION\ServiceCtrlPc.exe >> %RepertoireLog%
copy .\ServiceCtrlPc.exe C:\ProgramData\CtrlPc\INSTALLATION\ServiceCtrlPc.exe >> %RepertoireLog%
echo %date% %time% : Déplacement fichier ServiceCtrlPc.exe.config vers C:\ProgramData\CtrlPc\INSTALLATION\ServiceCtrlPc.exe.config >> %RepertoireLog%
copy .\ServiceCtrlPc.exe.config C:\ProgramData\CtrlPc\INSTALLATION\ServiceCtrlPc.exe.config >> %RepertoireLog%
echo %date% %time% : Déplacement fichier RemLogWS.exe.config vers C:\ProgramData\CtrlPc\SCRIPT\RemLogWS.exe.config >> %RepertoireLog%
copy .\RemLogWS.exe.config C:\ProgramData\CtrlPc\SCRIPT\RemLogWS.exe.config >> %RepertoireLog%
echo %date% %time% : Déplacement fichier RemLogWS.exe vers C:\ProgramData\CtrlPc\SCRIPT\RemLogWS.exe >> %RepertoireLog%
copy .\RemLogWS.exe C:\ProgramData\CtrlPc\SCRIPT\RemLogWS.exe >> %RepertoireLog%
echo %date% %time% : Déplacement fichier GeneFileParam.exe.config vers C:\ProgramData\CtrlPc\SCRIPT\GeneFileParam.exe.config >> %RepertoireLog%
copy .\GeneFileParam.exe.config C:\ProgramData\CtrlPc\SCRIPT\GeneFileParam.exe.config >> %RepertoireLog%
echo %date% %time% : Déplacement fichier GeneFileParam.exe vers C:\ProgramData\CtrlPc\SCRIPT\GeneFileParam.exe >> %RepertoireLog%
copy .\GeneFileParam.exe C:\ProgramData\CtrlPc\SCRIPT\GeneFileParam.exe >> %RepertoireLog%
echo %date% %time% : Déplacement fichier DownloadFile.exe.config vers C:\ProgramData\CtrlPc\SCRIPT\DownloadFile.exe.config >> %RepertoireLog%
copy .\DownloadFile.exe.config C:\ProgramData\CtrlPc\SCRIPT\DownloadFile.exe.config >> %RepertoireLog%
echo %date% %time% : Déplacement fichier DownloadFile.exe vers C:\ProgramData\CtrlPc\SCRIPT\DownloadFile.exe >> %RepertoireLog%
copy .\DownloadFile.exe C:\ProgramData\CtrlPc\SCRIPT\DownloadFile.exe >> %RepertoireLog%
echo %date% %time% : Fin de déplacement fichier >> %RepertoireLog%

echo %date% %time% : Installation du service >> %RepertoireLog%
cd C:\Windows\Microsoft.NET\Framework\v4.0.30319 >> %RepertoireLog%
start /wait InstallUtil.exe C:\ProgramData\CtrlPc\INSTALLATION\ServiceCtrlPc.exe >> %RepertoireLog%

SET i=0
:StartSrv
SET /A i = %i%+1
IF %i%==6 ( GOTO END )
echo %date% %time% : Démarrage du service >> %RepertoireLog%
echo %date% %time% : Tentative : %i% >> %RepertoireLog%
Net start /wait ServiceCtrlPc >> %RepertoireLog%
TIMEOUT /T 10 /NOBREAK
for /f "tokens=4 delims= " %%i in ( '"sc query ServiceCtrlPc | find "STATE"" ' ) do set StatutService=%%i
echo %date% %time% : Statut du service : %StatutService% >> %RepertoireLog%
IF %StatutService% NEQ RUNNING ( GOTO StartSrv ) ELSE ( GOTO registre )


:registre
echo %date% %time% : Création clé de registre >> %RepertoireLog%
for /f "tokens=1 delims= " %%i in ( C:\ProgramData\CtrlPc\TEMP\version.txt ) do set version=%%i

REG QUERY HKEY_USERS\.DEFAULT\Software\CtrlPc
IF errorlevel 1 REG ADD HKEY_USERS\.DEFAULT\Software\CtrlPc

REG QUERY HKEY_USERS\.DEFAULT\Software\CtrlPc\Version
IF errorlevel 1 REG ADD HKEY_USERS\.DEFAULT\Software\CtrlPc\Version

REG ADD HKEY_USERS\.DEFAULT\Software\CtrlPc\Version /V Version /T REG_SZ /D %version% /f
REG ADD HKEY_USERS\.DEFAULT\Software\CtrlPc\Version /V DateMaj /T REG_SZ /D %date% /f

echo %date% %time% : Controle présence GUID >> %RepertoireLog%
for /f %%a in ( '"POWERSHELL -COMMAND $([guid]::NewGuid().ToString())" ' ) do set NEWGUID=%%a
REG QUERY HKEY_USERS\.DEFAULT\Software\CtrlPc\Version | find "GUID"
IF errorlevel 1 (REG ADD HKEY_USERS\.DEFAULT\Software\CtrlPc\Version /V GUID /T REG_SZ /D %NEWGUID%)

for /f "tokens=1 delims= " %%i in ( C:\ProgramData\CtrlPc\TEMP\identifiant.txt ) do set identifiant=%%i >> %RepertoireLog%
echo %date% %time% : Identifiant : %identifiant% >> %RepertoireLog%
REG QUERY HKEY_USERS\.DEFAULT\Software\CtrlPc\Version | find "Identifiant" >> %RepertoireLog%
IF errorlevel 1 (REG ADD HKEY_USERS\.DEFAULT\Software\CtrlPc\Version /V Identifiant /T REG_SZ /D %identifiant% >> %RepertoireLog%)

:END
echo %date% %time% : Installation terminée >> %RepertoireLog%

echo %date% %time% : Préparation avant remontées des logs de mise à jour >> %RepertoireLog%
echo %date% %time% : Déplace FinMajInstall.exe >> %RepertoireLog%
copy C:\ProgramData\CtrlPc\TEMP\FinMajInstall.exe C:\ProgramData\CtrlPc\SCRIPT\FinMajInstall.exe >> %RepertoireLog%
copy C:\ProgramData\CtrlPc\TEMP\FinMajInstall.exe.config C:\ProgramData\CtrlPc\SCRIPT\FinMajInstall.exe.config >> %RepertoireLog%
echo %date% %time% : Exécution de FinMajInstall.exe >> %RepertoireLog%
TIMEOUT /T 5 /NOBREAK
copy C:\ProgramData\CtrlPc\TEMP\Install.log C:\ProgramData\CtrlPc\LOG\Install.log
start C:\ProgramData\CtrlPc\SCRIPT\FinMajInstall.exe
