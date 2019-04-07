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
	Type cConnection(URL As String, Username As String, Password As String)
	Type cLogin(id As Int,organization_id As Int,login As String,firstname As String,lastname As String,active As Boolean,	isAdmin As Boolean, isAgent As Boolean, isCustomer As Boolean,organization As String)
	Type cOrg (id As Int,	name As String,	active As Boolean)	
	Type cUser(id As Int,organization_id As Int,firstname As String,lastname As String,active As Boolean)
	Type cTicket(id As Int,state As String,number As Int, title As String)	
	Type cArticle(id As Int,body As String)
End Sub