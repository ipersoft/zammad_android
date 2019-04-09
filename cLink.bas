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
public Sub GetTicketCustomer(j As HttpJob) As HttpJob
	j.Download(c.URL & "/api/v1/tickets/search?query=customer_id:" & l.id & "&expand=true&sort_by=created_at&order_by=desc")
	Return BasicConfig(j)
End Sub
public Sub GetArticlesTicket(j As HttpJob, ID As Int) As HttpJob
	j.Download(c.URL & "/api/v1/ticket_articles/by_ticket/" & ID)
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