B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@
Sub Class_Globals
	Public Language As Int
	

	Public Const LANGUAGE_ITA As Int =1
	Public Const LANGUAGE_ENG As Int =2

	Private StringMap As Map

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

	
	StringMap=CreateMap( _
		"Status" :CreateMap( _
			LANGUAGE_ITA:"Stato", _
			LANGUAGE_ENG:"Status"), _
		"open" :CreateMap( _
			LANGUAGE_ITA:"Aperto", _
			LANGUAGE_ENG:"Open"), _
		"Loading ticket" :CreateMap( _
			LANGUAGE_ITA:"Caricamento ticket", _
			LANGUAGE_ENG:"Loading ticket"), _
		"Connection in progress" :CreateMap( _
			LANGUAGE_ITA:"Connessione in corso", _
			LANGUAGE_ENG:"Connection in progress") _			
	)
	
	
End Sub
Public Sub GetString(Value As String) As String
	If StringMap.ContainsKey(Value) Then
		Dim m As Map
		m=StringMap.Get(Value)
		If m.ContainsKey(Language) Then
			Return m.Get(Language)
		Else
			Return Value
		End If
	Else
		Return Value
	End If
End Sub

