B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@
Sub Class_Globals
	Private mGlobal As Map
	Public lGlobal As List
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub
Sub LoadJson(sJson As String) As Boolean
	Try
		Dim jP As JSONParser
		jP.Initialize(sJson)
		
		mGlobal.Initialize
		lGlobal.Initialize
		
		Dim listObj As List
		listObj=jP.NextArray
		
		Dim n As Int
		
		For n=0 To listObj.Size -1
			Dim mMap As Map
			mMap.Initialize
			mMap=listObj.Get(n)
			
			Dim jUser As cUser
			jUser.Initialize
			jUser.id=mMap.Get("id")
			jUser.active=mMap.Get("active")
			If mMap.Get("firstname")<>Null Then
				jUser.firstname=mMap.Get("firstname")
			End If
			If mMap.Get("lastname")<>Null Then
				jUser.lastname=mMap.Get("lastname")
			End If
			If mMap.Get("organization_id")<>Null Then
				jUser.organization_id=mMap.Get("organization_id")
			End If
			
			If jUser.active=True Then
				mGlobal.Put(jUser.id,jUser)
				lGlobal.Add(jUser)
			End If			
		Next
		Return True
	Catch
		Return False
		Log(LastException)
	End Try
End Sub
Sub user(id As Int) As cUser
	Try
		Dim cObj As cUser
		cObj=mGlobal.Get(id)
		Return cObj
	Catch
		Log(LastException)
		Return Null
	End Try
End Sub
