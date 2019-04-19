B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region
#Extends: de.amberhome.preferences.AppCompatPreferenceActivity
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private ActionBar As ACToolBarLight
	Private pContent As Panel
	Private ABHelper As ACActionBar
	

	Private PView As PreferenceView
	Private PrefManager As PreferenceManager
	Dim kC As KeyValueStore
	
End Sub

Sub Activity_Create(FirstTime As Boolean)
	
	kC=Starter.kConfig
	
	Activity.LoadLayout("laypref")
	ActionBar.Title="Preferences"
	ABHelper.Initialize
	ABHelper.ShowUpIndicator = True
	ActionBar.InitMenuListener

End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub ActionBar_NavigationItemClick
	kC.Put("SavePassword",PrefManager.GetBoolean("password"))
	If PrefManager.GetBoolean("password")=False Then
		kC.Remove("PASSWORD")
	End If
	Activity.Finish
End Sub

Sub PView_Ready (PrefsView As PreferenceView)
	Log("PView_Ready")
	PrefsView.AddCheckBoxPreference("", "password", "Save Password", "Enable", "Disable", kC.GetDefault("SavePassword",False))
End Sub
	
