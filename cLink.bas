B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@
Sub Class_Globals
	Public c As cConnection	
	Public m As cMy
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
	j.Download(c.URL & "/api/v1/users/me")
	Return BasicConfig(j)
End Sub
public Sub GetOrgs(j As HttpJob)	As HttpJob
	j.Download(c.URL & "/api/v1/organizations/")
	Return BasicConfig(j)
End Sub
public Sub GetNotifications(j As HttpJob) As HttpJob
	j.Download(c.URL & "/api/v1/online_notifications/")
	Return BasicConfig(j)
End Sub