; Script Inno Setup - Jaguar Security Services Admin
#define AppName "Jaguar Security Services Admin"
#define AppVersion "1.0.0"
#define AppExe "jaguar_admin.exe"
#define BuildDir "..\build\windows\x64\runner\Release"

[Setup]
AppId={{B6C1D0E4-7A52-4F0B-9C3A-5E2D8F1A7C90}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher=Jaguar Security Services
DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}
OutputDir=output
OutputBaseFilename=JaguarAdmin-Setup-{#AppVersion}
Compression=lzma2
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64compatible
WizardStyle=modern
PrivilegesRequired=admin
UninstallDisplayIcon={app}\{#AppExe}

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[Tasks]
Name: "desktopicon"; Description: "Créer un raccourci sur le Bureau"; GroupDescription: "Raccourcis :"

[Files]
Source: "{#BuildDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExe}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExe}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#AppExe}"; Description: "Lancer {#AppName}"; Flags: nowait postinstall skipifsilent
