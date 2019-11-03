;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;General

  ;Name and file
  Name "Sperocoin Electrum"
  OutFile "dist/sperocoin-electrum-setup.exe"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\Sperocoin-Electrum"

  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\Sperocoin-Electrum" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel admin

;--------------------------------
;Variables

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  ;!insertmacro MUI_PAGE_LICENSE "tmp/LICENCE"
  ;!insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY

  ;Start Menu Folder Page Configuration
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU"
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\Sperocoin-Electrum"
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"

  ;!insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder

  !insertmacro MUI_PAGE_INSTFILES

  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section

  SetOutPath "$INSTDIR"

  ;ADD YOUR OWN FILES HERE...
  file /r dist\sperocoin-electrum\*.*

  ;Store installation folder
  WriteRegStr HKCU "Software\Sperocoin-Electrum" "" $INSTDIR

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"


  CreateShortCut "$DESKTOP\Sperocoin-Electrum.lnk" "$INSTDIR\sperocoin-electrum.exe" ""

  ;create start-menu items
  CreateDirectory "$SMPROGRAMS\Sperocoin-Electrum"
  CreateShortCut "$SMPROGRAMS\Sperocoin-Electrum\Uninstall.lnk" "$INSTDIR\Uninstall.exe" "" "$INSTDIR\Uninstall.exe" 0
  CreateShortCut "$SMPROGRAMS\Sperocoin-Electrum\Sperocoin-Electrum.lnk" "$INSTDIR\sperocoin-electrum.exe" "" "$INSTDIR\sperocoin-electrum.exe" 0

SectionEnd

;--------------------------------
;Descriptions

  ;Assign language strings to sections
  ;!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  ;  !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
  ;!insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...
  RMDir /r "$INSTDIR\*.*"

  RMDir "$INSTDIR"

  Delete "$DESKTOP\Sperocoin-Electrum.lnk"
  Delete "$SMPROGRAMS\Sperocoin-Electrum\*.*"
  RmDir  "$SMPROGRAMS\Sperocoin-Electrum"

  DeleteRegKey /ifempty HKCU "Software\Sperocoin-Electrum"

SectionEnd
