Set args = WScript.Arguments

If args.Count = 0 Then
    WScript.Quit 1
End If

If args.Count >= 3 Then
    Title = args(0)
    Text = args(1)
    Icon = args(2)
End If

Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.Popup Text, 0, Title, Icon