B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@
Sub Class_Globals
	Public Language As String
	Private StringMap As Map
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

	CreateStringMap("Connection in progress","ITA","Connessione in corso")
	
End Sub
Public Sub Translate(Value As String) As String
	If StringMap.ContainsKey(Value) Then
		Dim m As Map
		m=StringMap.Get(Value)
		If m.ContainsKey(Language) Then
			Return m.Get(Language)
		Else
			LogColor(Value,Colors.Yellow)
			Return Value
		End If
	Else
		LogColor(Value,Colors.Yellow)
		Return Value
	End If
End Sub

Private Sub CreateStringMap(k As String,l As String,t As String)
	If StringMap.IsInitialized=False Then
		StringMap.Initialize
	End If
	If StringMap.ContainsKey(k)=False Then		
		StringMap.Put(k,CreateMap(l:t))
		Else
		Dim m As Map
		m=StringMap.Get(k)
		m.Put(l,t)
		StringMap.Put(k,m)
	End If
End Sub
