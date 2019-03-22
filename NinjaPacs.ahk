;***************************************************************************
;Radiopaedia search
#Scrolllock::

BlockInput, on
prevClipboard = %clipboard% ;set current clipboard to a variable, to be reinstated at the end
Send ^c ;copies currently selected text
BlockInput, off
ClipWait, 2
if ErrorLevel = 0
{
searchQuery=%clipboard% ;sets highlighted text to search variable
GoSub, RPSearch
}

clipboard = %prevClipboard% ;returns previous Clipboard data
return

RPSearch: ;script to remove space characters, etc.
StringReplace, searchQuery, searchQuery, `r`n, %A_Space%, All
Loop 
   { 
      noExtraSpaces=1 
      StringLeft, leftMost, searchQuery, 1 
      IfInString, leftMost, %A_Space% 
      { 
         StringTrimLeft, searchQuery, searchQuery, 1 
         noExtraSpaces=0 
      } 
      StringRight, rightMost, searchQuery, 1 
      IfInString, rightMost, %A_Space% 
      { 
         StringTrimRight, searchQuery, searchQuery, 1 
         noExtraSpaces=0 
      } 
      If (noExtraSpaces=1) 
         break 
   } 
   StringReplace, searchQuery, searchQuery, \, `%5C, All 
   StringReplace, searchQuery, searchQuery, %A_Space%, +, All 
   StringReplace, searchQuery, searchQuery, `%, `%25, All 

 Run www.radiopaedia.org/search?q=%searchQuery%&scope=all ;search RP
return ;close sub-script


;***************************************************************************
;Shortcut to Radiology Intranet

#A::
Run, http://172.28.40.180
return


;***************************************************************************
;Shortcuts to All Studies, All Recent Studies, Conferences

;All Studies
#Z::
Run \\RADFILES2\Everyone\NinjaPACS\Synapse.lnk
return

;***************************************************************************
;Remove Interim banner, return to signature area

#S::
IfWinExist, Dictate
{
WinActivate Dictate
Send ^F
Send -IMPORTANT-
Send !D
Send {Tab}
Send {Enter}
Send {Shift Down}
Send {down}
Send {down}
Send {down}
Send {down}
Send {Home}
Send {Shift Up}
Send {Del}
Send ^{End}
Send {Up}
return
} 

IfWinExist, Batch
{
WinActivate Batch
Send ^F
Send -IMPORTANT-
Send !D
Send {Tab}
Send {Enter}
Send {Shift Down}
Send {down}
Send {down}
Send {down}
Send {down}
Send {Home}
Send {Shift Up}
Send {Del}
Send ^{End}
Send {Up}
return
} 

IfWinExist, Edit Report
{
WinActivate Edit
Send ^F
Send -IMPORTANT-
Send !D
Send {Tab}
Send {Enter}
Send {Shift Down}
Send {down}
Send {down}
Send {down}
Send {down}
Send {Home}
Send {Shift Up}
Send {Del}
Send ^{End}
Send {Up}
return
} 


;***************************************************************************
;Interim and fix first line

#I::
IfWinExist, Dictate
{
WinActivate Dictate
Send ^{Home}
Send int2
Send ^{Space}
Send {down}
Send {Shift Down}
Send {down}
Send {Shift Up}
Send ^B
Send ^U
return
}

IfWinExist, Batch
{
WinActivate Batch
Send ^{Home}
Send int2
Send ^{Space}
Send {down}
Send {Shift Down}
Send {down}
Send {Shift Up}
Send ^B
Send ^U
return
}

IfWinExist, Edit Report
{
WinActivate Edit Report
Send ^{Home}
Send int2
Send ^{Space}
Send {down}
Send {Shift Down}
Send {down}
Send {Shift Up}
Send ^B
Send ^U
return
}


;***************************************************************************
;Shift focus to Karisma reporting
#Left::
IfWinExist, Dictate
{
WinActivate Dictate
}

IfWinExist, Batch
{
WinActivate Batch
}

IfWinExist, Edit Report
{
WinActivate Edit Report
}
return




;***************************************************************************
;Shift focus to power jacket
#UP::
IfWinExist, Patient Information
{
WinActivate Patient Information
WinMaximize Patient Information
}
IfWinExist, /Karisma Studies
{
WinActivate /Karisma Studies
WinMaximize /Karisma Studies
}
return

;***************************************************************************
;minimizes power Jacket

#Down::
IfWinExist, Patient Information
{
WinActivate Patient Information
WinMinimize Patient Information
}
return

;***************************************************************************
;Screencapture

#PrintScreen::
Run %A_WinDir%\System32\SnippingTool.exe

IfWinExist, Snipping
{
WinActivate Snipping
Send ^N
}
return


;***************************************************************************
;Fix leading space / line and bold underline heading

#Ins::
IfWinExist, Dictate
{
WinActivate Dictate
Send ^{Home}
Send {Delete}
Send {Shift Down}
Send {down}
Send {Shift Up}
Send ^B
Send ^U
return
}

IfWinExist, Batch
{
WinActivate Batch
Send ^{Home}
Send {Delete}
Send {Shift Down}
Send {down}
Send {Shift Up}
Send ^B
Send ^U
return
}

IfWinExist, Edit Report
{
WinActivate Edit Report
Send ^{Home}
Send {Delete}
Send {Shift Down}
Send {down}
Send {Shift Up}
Send ^B
Send ^U
return
}


;***************************************************************************
;Authorize report - now with delay!

#End UP::
KeyWait LWin
KeyWait RWin
IfWinExist, Dictate
{
WinActivate Dictate
Send !L
return
}

IfWinExist, Batch
{
WinActivate Batch
Send !L
return
}

IfWinExist, Edit Report
{
WinActivate Edit Report
Send !L
return
}

;***************************************************************************
;SpeechMagic Microphone Pause/On

$NumpadAdd::
SetTitleMatchMode, 2
If WinExist("[SpeechMagic6]"){
	ControlSend, TWPSpeechMagic1, {NumpadAdd}, ,ReportBannerActorPanel
	SetTitleMatchMode, 1
	return
}
else Send {NumpadAdd}
SetTitleMatchMode, 1
return

;***************************************************************************
;Synapse Previous/Next Reading Protocol

Alt & Right::
DetectHiddenText, On
synapseInstance=""
if (WinExist("http://rmh-synapse")) 
{
	synapseInstance = http://rmh-synapse
}
else If (WinExist("Synapse")) 
{
	synapseInstance = Synapse
}

IfWinExist,%synapseInstance%
{
WinGetActiveTitle, thiswinid
WinActivate %synapseInstance%
IfWinActive %synapseInstance%
Send {Alt down}s{Alt up}
WinActivate %thiswinid%
}
else Send {Alt down}{Right}{Alt up}
DetectHiddenText, On
return

Alt & Left::
synapseInstance=""
if (WinExist("http://rmh-synapse")) 
{
	synapseInstance = http://rmh-synapse
}
else If (WinExist("Synapse")) 
{
	synapseInstance = Synapse
}

IfWinExist,%synapseInstance%
{
WinGetActiveTitle, thiswinid
WinActivate %synapseInstance%
IfWinActive %synapseInstance%
Send {Alt down}a{Alt up}
WinActivate %thiswinid%
}
else Send {Alt down}{Left}{Alt up}
DetectHiddenText, On
return

;***************************************************************************
; Kill all instances of IE and clear IE cache

!+i::
Run, taskkill.exe /f /im iexplore.exe /t
; Run, runDll32.exe InetCpl.cpl`,ClearMyTracksByProcess 8
return

; Restart Windows Explorer

!+e::
Process, Close, explorer.exe
Sleep, 5000
return

;***************************************************************************
;help

#/::
GoSub, HelpBox
return

#*?::
GoSub, HelpBox
return

HelpBox:
MsgBox ,, Keyboard shortcuts,  The following keyboard shortcuts exist: `n `n Karisma dictation window = Win + left arrow `n PowerJacket hide = Win + down arrow `n PowerJacket maximize = Win + up arrow `n Next Reading Protocol = Alt + right arrow `n Prev. Reading Protocol = Alt + left arrow `n `n Format first line heading (remove new line and leading space) = Win + Insert `n Insert Interim Red Warning and Format first line = Win + I  `n Remove Interim Red Warning and move cursor to end of document = Win + S `n Authorise report = Win + End `n `n Synapse Windows Shortcut = Win + Z `n `n Screen Capture = Win + PrtScr `n Search highlighted text in Radiopaedia = Win + Scroll Lock `n Radiology Intranet Page = Win + A `n `n SpeechMagic Microphone On/Pause = Numpad + `n `n Kill I.E. = Alt + Shift + i `n Kill explorer = Alt + Shift + e `n `n Help = Win + ?  `n `n Version 0.994, 
return



;***************************************************************************
