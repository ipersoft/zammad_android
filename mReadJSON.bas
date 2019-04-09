B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub
public Sub JSONLogin(sJSON As String) As cLogin
	Try
		Dim jP As JSONParser
		Dim cOBJ As cLogin
		jP.Initialize(sJSON)
		Dim mOBJ As Map
		mOBJ=jP.NextObject
		cOBJ.id=mOBJ.Get("id")
		cOBJ.active=mOBJ.Get("active")
		cOBJ.login=mOBJ.Get("login")
		cOBJ.firstname=mOBJ.Get("firstname")
		cOBJ.lastname=mOBJ.Get("lastname")
		cOBJ.organization_id=mOBJ.Get("organization_id")
		cOBJ.organization=mOBJ.Get("organization")
		
		Dim Perms As List
		Perms=mOBJ.Get("role_ids")
		Dim n As Int
		For n=0 To Perms.Size-1
			Select Case Perms.Get(n)
				Case 1
					cOBJ.isAdmin=True
				Case 2
					cOBJ.isAgent=True
				Case 3
					cOBJ.isCustomer=True
			End Select
		Next
		
		Return cOBJ
	Catch
		Log(LastException)
		Return Null		
	End Try
End Sub
public Sub JSONListTicket(sJSON As String) As List
	Dim jP As JSONParser	
	jP.Initialize(sJSON)

	Dim cListOBJ As List	
	cListOBJ.Initialize
	
	Dim mOBJ As Map
	
	Dim ListOBJ As List
	ListOBJ=jP.NextArray
	Dim n As Int
	For n=0 To ListOBJ.Size-1
		Dim cOBJ As cTicket
		mOBJ=ListOBJ.Get(n)
		cOBJ.id=mOBJ.Get("id")
		cOBJ.state=mOBJ.Get("state")
		cOBJ.number=mOBJ.Get("number")
		cOBJ.title=mOBJ.Get("title")
		cOBJ.organization=mOBJ.Get("organization")
		cListOBJ.Add(cOBJ)		
	Next
	Return cListOBJ
End Sub