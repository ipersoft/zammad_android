B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@
Sub Class_Globals
	Public  UserAgent As String="ZammadAndroid"
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub
public Sub Wait(sMessage As String)
	ProgressDialogShow(sMessage)
End Sub
Public Sub EndWait
	ProgressDialogHide
End Sub