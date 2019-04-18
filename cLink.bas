B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@
Sub Class_Globals
	Public c As cConnection	
	Public m As cMy
	Public l As cLogin
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub
private Sub BasicConfig(j As HttpJob) As HttpJob
	j.Username=c.Username
	j.Password=c.Password
	j.GetRequest.SetHeader("User-Agent",m.UserAgent)
	Return j
End Sub
public Sub GetUser(j As HttpJob)	As HttpJob
	j.Download(c.URL & "/api/v1/users/me?expand=true")
	Return BasicConfig(j)
End Sub
public Sub GetOrgs(j As HttpJob)	As HttpJob
	j.Download(c.URL & "/api/v1/organizations/")
	Return BasicConfig(j)
End Sub
public Sub GetUsers(j As HttpJob)	As HttpJob
	j.Download(c.URL & "/api/v1/users/")
	Return BasicConfig(j)
End Sub
public Sub GetNotifications(j As HttpJob) As HttpJob
	j.Download(c.URL & "/api/v1/online_notifications/")
	Return BasicConfig(j)
End Sub
public Sub GetTicketCustomer(j As HttpJob,StatusOpen As Boolean,StatusClosed As Boolean) As HttpJob
	Dim sStatus As String
	If StatusOpen And StatusClosed Then
		sStatus=" state:(open OR closed)"
	End If
	If StatusOpen=True And StatusClosed=False Then
		sStatus=" state:open"
	End If
	If StatusOpen=False And StatusClosed=True Then
		sStatus=" state:closed"
	End If
	j.Download(c.URL & "/api/v1/tickets/search?query=customer_id:" & l.id & " AND " & sStatus & "&expand=true&sort_by=created_at&order_by=desc")
	Return BasicConfig(j)
End Sub
public Sub GetArticlesTicket(j As HttpJob, ID As Int) As HttpJob
	j.Download(c.URL & "/api/v1/ticket_articles/by_ticket/" & ID)
	Return BasicConfig(j)	
End Sub
public Sub PutArticlesTicket(j As HttpJob,NewArticle As Map) As HttpJob
	Dim js As JSONGenerator
	js.Initialize(NewArticle)
	Log(js.ToString)
	j.PostString(c.URL & "/api/v1/ticket_articles",js.ToString)
	j.GetRequest.SetContentType("application/json")
	Return BasicConfig(j)	
End Sub
public Sub ModifyTicket(j As HttpJob,ID As Int,NewArticle As Map) As HttpJob
	Dim js As JSONGenerator
	js.Initialize(NewArticle)
	Log(js.ToString)
	j.PutString(c.URL & "/api/v1/tickets/" & ID,js.ToString)
	j.GetRequest.SetContentType("application/json")
	Return BasicConfig(j)	
End Sub
Public Sub GetGenericLink(j As HttpJob,sLink As String) As HttpJob
	j.Download(c.URL & sLink)
	Return BasicConfig(j)
End Sub
public Sub GetTicketAgentStatus(j As HttpJob,status As String) As HttpJob
	j.Download(c.URL & "/api/v1/tickets/search?query=owner_id:" & l.id  & " AND state:" & status & "&expand=true&sort_by=created_at&order_by=asc")
	Return BasicConfig(j)
End Sub
public Sub GetTicketUnassigned(j As HttpJob) As HttpJob
	j.Download(c.URL & "/api/v1/tickets/search?query=owner_id:1 AND state:(open OR new)&expand=true&sort_by=created_at&order_by=asc")
	Return BasicConfig(j)
End Sub