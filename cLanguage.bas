B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@
Sub Class_Globals
	Public LANGUAGE As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub
Public Sub ConnectionInProgress As String
Select Case LANGUAGE
	Case "ITA"
		Return "Connessione in corso ..."
	Case "ENG"
		Return "Connection in progress ..."
End Select
End Sub
public Sub LoadingOrganizations As String
	Select Case LANGUAGE
		Case "ITA"
			Return "Caricamento aziende ..."
		Case "ENG"
			Return "Loading organizations ..."
	End Select
End Sub
public Sub LoadingNotifications As String
	Select Case LANGUAGE
		Case "ITA"
			Return "Caricamento notifiche ..."
		Case "ENG"
			Return "Loading notifications ..."
	End Select
End Sub