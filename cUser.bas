B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@
Sub Class_Globals
	Public id As Int
	Public active As Boolean
	Public login As String
	Public firstname As String
	Public lastname As String
	Public organization_id As Int
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub
Sub LoadJson(sJson As String) As Boolean
	Try
		Dim jP As JSONParser
		jP.Initialize(sJson)
		Dim mUser As Map
		mUser=jP.NextObject
		id=mUser.Get("id")
		active=mUser.Get("active")
		login=mUser.Get("login")
		firstname=mUser.Get("firstname")
		lastname=mUser.Get("lastname")
		organization_id=mUser.Get("organization_id")
		Return True
	Catch
		Return False
		Log(LastException)
	End Try
End Sub