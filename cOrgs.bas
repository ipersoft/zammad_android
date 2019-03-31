B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@
Sub Class_Globals
	Private mOrgs As Map
	Public lOrgs As List
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub
Sub LoadJson(sJson As String) As Boolean
	Try
		Dim jP As JSONParser
		jP.Initialize(sJson)
		
		mOrgs.Initialize
		lOrgs.Initialize
		
		Dim listOrgs As List
		listOrgs=jP.NextArray
		Dim n As Int
		For n=0 To listOrgs.Size -1
			Dim mOrg As Map
			mOrg.Initialize
			mOrg=listOrgs.Get(n)
			Dim jOrg As cOrg
			jOrg.Initialize
			jOrg.id=mOrg.Get("id")
			jOrg.active=mOrg.Get("active")
			jOrg.name=mOrg.Get("name")
			If jOrg.active=True Then
				mOrgs.Put(jOrg.id,jOrg)
				lOrgs.Add(jOrg)			
			End If
		Next		
		Return True
	Catch
		Return False
		Log(LastException)
	End Try
End Sub
Sub org(id As Int) As cOrg
	Try
		Dim mOrg As cOrg
		mOrg=mOrgs.Get(id)
		Return mOrg
	Catch
		Log(LastException)
		Return Null
	End Try
End Sub
