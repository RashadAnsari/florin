; Inno Setup script for the Florin Windows installer.
; Built in CI with: iscc /DAppVersion=<version> /DBuildDir=<release folder> windows\installer.iss

#ifndef AppVersion
  #define AppVersion "0.0.0"
#endif
#ifndef BuildDir
  #define BuildDir "..\build\windows\x64\runner\Release"
#endif

[Setup]
; AppId identifies the app across upgrades and uninstall: never change it
AppId={{C2F6FA27-090F-4F6B-B196-07C17D79ABA5}
AppName=Florin
AppVersion={#AppVersion}
AppPublisher=Rashad Ansari
AppPublisherURL=https://github.com/RashadAnsari/florin
DefaultDirName={autopf}\Florin
DefaultGroupName=Florin
DisableProgramGroupPage=yes
; Per-user install: no administrator prompt
PrivilegesRequired=lowest
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
SetupIconFile=runner\resources\app_icon.ico
UninstallDisplayIcon={app}\florin.exe
OutputDir=..
OutputBaseFilename=florin-windows-x64-setup
Compression=lzma2
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "dutch"; MessagesFile: "compiler:Languages\Dutch.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "{#BuildDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\Florin"; Filename: "{app}\florin.exe"
Name: "{autodesktop}\Florin"; Filename: "{app}\florin.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\florin.exe"; Description: "{cm:LaunchProgram,Florin}"; Flags: nowait postinstall skipifsilent
