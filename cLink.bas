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
public Sub GetTicketUser(j As HttpJob) As HttpJob
	j.Download(c.URL & "/api/v1/tickets/search?query=customer_id:" & l.id & "&expand=true&sort_by=created_at&order_by=desc")
	Return BasicConfig(j)
End Sub