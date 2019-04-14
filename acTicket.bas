B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
	#Extends: android.support.v7.app.AppCompatActivity
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Public gTicket As cTicket
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private ActionBar As ACToolBarLight
	Private pContent As Panel
	Private ABHelper As ACActionBar
	Private webv As WebView
	Private VP As AHViewPager
	Private PC As AHPageContainer
	Private TabLayout As DSTabLayout
	Private AddButton As DSFloatingActionButton
	Private nPage As Int
	Private NewTicket As CustomLayoutDialog
	Private TicketStatus As B4XComboBox
	Private TicketText As B4XFloatTextField
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("layhome")
	ABHelper.Initialize
	ABHelper.ShowUpIndicator = True
	ActionBar.InitMenuListener
	ActionBar.Elevation=0
	ActionBar.Title=gTicket.title
	ActionBar.SubTitle=Main.gL.GetString("Status") & ": " & Main.gL.GetString(gTicket.state)


	LoadTicket
	
End Sub
Sub LoadTicket
	pContent.RemoveAllViews
	pContent.LoadLayout("laypaper")
	pContent.LoadLayout("layaddbutton")

	
	PC.Initialize
	Dim ac As AppCompat
	TabLayout.Color = ac.GetThemeAttribute("colorPrimary")
	VP.PageContainer = PC
	
	TabLayout.SetViewPager(VP)
	Dim j As HttpJob
	j.Initialize("",Me)
	j=Main.gLink.GetArticlesTicket(j,gTicket.id)
	ProgressDialogShow(Main.gL.GetString("Loading ticket") & " ...")
	Wait For (j) JobDone(j As HttpJob)
	
	If j.Success=True Then
		Dim jP As JSONParser
		jP.Initialize(j.GetString)
		Dim lArticles As List
		Dim mArticle As Map
		lArticles=jP.NextArray
		Dim n As Int
		nPage=lArticles.Size-1
		For n=0 To lArticles.Size-1
			
			mArticle=lArticles.Get(n)
			Log(mArticle.Get("updated_at"))
			'iDate=xi.Parse( mArticle.Get("updated_at"))
			Dim p As Panel
			p.Initialize("")
			p.LoadLayout("layweb")
			Wait For  (ParseBody(mArticle.Get("body"))) complete (sWeb As String)
			webv.LoadHtml(sWeb)
			mUtility.DisableButtonZoom(webv)
			'PC.AddPage(p,DateTime.GetDayOfMonth(iDate) & " " & DateUtils.GetMonthName(iDate) & "(" &  (n+1) & "/" & lArticles.Size & ")")
			PC.AddPage(p,(n+1) & "/" & lArticles.Size )
			webv.Height=VP.Height
			webv.Width=VP.Width
		Next
		VP.CurrentPage=nPage
		ProgressDialogHide
	Else
		ProgressDialogHide
		ToastMessageShow("Error",False)
		Activity.Finish
	End If
End Sub
Sub ActionBar_NavigationItemClick
	Activity.Finish
End Sub
Sub ActionBar_MenuItemClick (Item As ACMenuItem)
	Msgbox(Item.Title,"")
End Sub
Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub
Sub ParseBody(sBody As String) As ResumableSub
	Dim matcher1 As Matcher
	matcher1 = Regex.Matcher("(\/api.*inline)", sBody)
	Do While matcher1.Find = True
		Log(matcher1.Match)
		Dim sImage As String
		Wait For (GetBase84(matcher1.Match)) complete (sImage As String)
		sBody=sBody.Replace(matcher1.Match,sImage) 
	Loop
	Return sBody
End Sub
Sub GetBase84(sImage As String) As ResumableSub
	Dim j As HttpJob
	j.Initialize("",Me)
	Main.gLink.GetGenericLink(j,sImage)
	Wait For (j) JobDone(j As HttpJob)
	If j.Success=True Then
		Return " data:image/png;base64," &  ImageToBase64(j.GetBitmap)
	Else
		Return sImage
	End If
End Sub
Sub ImageToBase64(img As Bitmap) As String
	Dim su As StringUtils
	Dim out As OutputStream
	out.InitializeToBytesArray(0)
	img.WriteToStream(out, 100, "JPEG")
	Return su.EncodeBase64(out.ToBytesArray)
End Sub


Sub webv_OverrideUrl (Url As String) As Boolean
	Return True
End Sub

Sub VP_PageChanged (Position As Int)
	If Position=nPage Then
		AddButton.Show
		Else
		AddButton.Hide
	End If
End Sub

Sub AddButton_Click
	Dim sf As Object = NewTicket.ShowAsync("New Response", "Send", "Cancel", "", Null, True)
	NewTicket.SetSize(100%x, 350dip)
	Wait For (sf) Dialog_Ready(pnl As Panel)
	pnl.LoadLayout("laynewticket")
	TicketStatus.cmbBox.Add("Status Open")
	TicketStatus.cmbBox.Add("Status Closed")
	TicketStatus.SelectedIndex=0
	NewTicket.GetButton(DialogResponse.POSITIVE).Enabled=False
	Wait For (sf) Dialog_Result(res As Int)
	TicketText.TextField.Enabled=False
	If res=DialogResponse.POSITIVE Then
		Dim NewArticle As Map
		Dim StatusTicket As Map
		NewArticle.Initialize
		StatusTicket.Initialize
		
		NewArticle.Put("ticket_id",gTicket.id)
		NewArticle.Put("body",TicketText.Text)
'		NewArticle.Put("type","note")
'		NewArticle.Put("internal",False)
'		NewArticle.Put("internal",False)
'		NewArticle.Put("internal",False)
'		'NewArticle.Put("time_unit","24")
'		
'		
'		NewArticle.Put("to","")
'		NewArticle.Put("cc","")
'		NewArticle.Put("subject","sottetto")
'		NewArticle.Put("content_type","text/html")

		StatusTicket.Put("id",gTicket.id)
		Select Case TicketStatus.SelectedIndex
			Case 0
				StatusTicket.Put("state_id",2)
			Case 1
				StatusTicket.Put("state_id",4)
		End Select
		
		ProgressDialogShow("Send ...")
		Dim j As HttpJob
		j.Initialize("",Me)
		If gTicket.state_id<>StatusTicket.Get("state_id") Then
			Main.gLink.ModifyTicket(j,gTicket.id,StatusTicket)
			Wait For (j) JobDone(j As HttpJob)
			If j.Success=True Then
				Log(j.GetString)
			Else
				ToastMessageShow("Error modify status ticket",False)
			End If
		End If
		
		Main.gLink.PutArticlesTicket(j,NewArticle)
		Wait For (j) JobDone(j As HttpJob)
		If j.Success=True Then
			Log(j.GetString)
		Else
			ToastMessageShow("Error insert article",False)
		End If
		
		j.Release
		ProgressDialogHide
		
		LoadTicket
		
	End If
End Sub

Sub TicketText_TextChanged (Old As String, New As String)
	If New.Length>0 Then
		NewTicket.GetButton(DialogResponse.POSITIVE).Enabled=True
		Else
		NewTicket.GetButton(DialogResponse.POSITIVE).Enabled=False
	End If
End Sub