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
	Public IDTicket As Int
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private ActionBar As ACToolBarLight
	Private pContent As Panel
	Private ABHelper As ACActionBar
	Private webv As WebView
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("layhome")
	ABHelper.Initialize
	ABHelper.ShowUpIndicator = True
	ActionBar.InitMenuListener

	Dim j As HttpJob
	j.Initialize("",Me)
	j=Main.gLink.GetArticlesTicket(j,IDTicket)
	ProgressDialogShow(Main.gL.GetString("Loading ticket") & " ...")
	Wait For (j) JobDone(j As HttpJob)
	
	If j.Success=True Then
		Dim jP As JSONParser
		jP.Initialize(j.GetString)
		Dim lArticles As List
		Dim mArticle As Map
		lArticles=jP.NextArray
		mArticle=lArticles.Get(0)
		pContent.LoadLayout("layweb")
		Wait For  (ParseBody(mArticle.Get("body"))) complete (sWeb As String)
		webv.LoadHtml(sWeb)
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