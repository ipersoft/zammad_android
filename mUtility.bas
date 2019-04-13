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
Sub DisableButtonZoom(w As WebView)
	Dim r As Reflector
	r.Target = w
	r.Target = r.RunMethod("getSettings")
	r.RunMethod2("setBuiltInZoomControls", True, "java.lang.boolean")
	r.RunMethod2("setDisplayZoomControls", False, "java.lang.boolean")
End Sub
