B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.01
@EndOfDesignText@
Sub Class_Globals
	Public  UserAgent As String="ZammadAndroid"
	Public  AppName As String="Zammad Android"
	
	
	Public gCon As cConnection
	Public gLogin As cLogin
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub
public Sub Connect As ResumableSub
	Dim j As HttpJob
	j.Initialize("",Me)
	j=LinkGetUser(j)
	Wait For (j) JobDone(j As HttpJob)
	If j.Success=False Then
		j.Release
		Return False
	Else
		gLogin=JsonToLogin(j.GetString)
		j.Release
		Return True
	End If
End Sub
#Region Public Sub
Public Sub GetTicketsUnassigned As ResumableSub
	Dim j As HttpJob
	j.Initialize("",Me)
	j=LinkGetTicketUnassigned(j)
	Wait For (j) JobDone(j As HttpJob)
	If j.Success=False Then
		j.Release
		Return Null
	Else
		Dim sJson As String=j.GetString
		j.Release
		Return JsonToListTicket(sJson)
	End If
	
End Sub
Public Sub GetTicket(ID As Int) As ResumableSub
	Dim j As HttpJob
	j.Initialize("",Me)
	j=LinkGetTicketSingle(j,ID)
	Wait For (j) JobDone(j As HttpJob)
	If j.Success=False Then
		j.Release
		Return Null
	Else
		Dim sJson As String=j.GetString
		j.Release
		Return JsonToTicket(sJson)
	End If
End Sub
#End Region
#Region Link
Sub BasicConfig(j As HttpJob) As HttpJob
	j.Username=gCon.Username
	j.Password=gCon.Password
	j.GetRequest.SetHeader("User-Agent",UserAgent)
	Return j
End Sub
Sub LinkGetUser(j As HttpJob)	As HttpJob
	j.Download(gCon.URL & "/api/v1/users/me?expand=true")
	Return BasicConfig(j)
End Sub
Sub LinkGetTicketSingle(j As HttpJob,ID As Int) As HttpJob
	j.Download(gCon.URL & "/api/v1/tickets/search?query=id:"  & ID & "&expand=true")
	Return BasicConfig(j)
End Sub
Sub LinkGetTicketUnassigned(j As HttpJob) As HttpJob
	j.Download(gCon.URL & "/api/v1/tickets/search?query=owner_id:1 AND state:(open OR new)&expand=true&sort_by=created_at&order_by=asc")
	Return BasicConfig(j)
End Sub
#End Region
#Region JsonToEnum
Sub JsonToLogin(sJSON As String) As cLogin
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
Sub JsonToTicket(sJSON As String) As cTicket
	Dim jP As JSONParser
	jP.Initialize(sJSON)
	Return MapToTicket(jP.NextObject)	
End Sub
Sub MapToTicket(mOBJ As Map) As cTicket
	Dim cOBJ As cTicket
	cOBJ.id=mOBJ.Get("id")
	cOBJ.state=mOBJ.Get("state")
	cOBJ.state_id=mOBJ.Get("state_id")
	cOBJ.number=mOBJ.Get("number")
	cOBJ.title=mOBJ.Get("title")
	cOBJ.organization=mOBJ.Get("organization")
	Return cOBJ
End Sub
Sub JsonToListTicket(sJSON As String) As List
	Dim jP As JSONParser
	jP.Initialize(sJSON)
	Dim cListOBJ As List
	cListOBJ.Initialize
	Dim ListOBJ As List
	ListOBJ=jP.NextArray
	Dim n As Int
	For n=0 To ListOBJ.Size-1
		Dim cOBJ As cTicket=MapToTicket( ListOBJ.Get(n))
		cListOBJ.Add(cOBJ)
	Next
	Return cListOBJ
End Sub
#End Region