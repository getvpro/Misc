# Misc
This code exists to resolve issues on Citrix Win 10 / Win 201x desktops where a BLACK screen is presented to users, and where EXPLORER never launches the desktop
The scheduled task calls a VBS script
On importing the schedudled task, you will need to edit line 44, to put in a path to the VBS script, example below
Why am I using VBS instead of PS ? I didn't want a PS window shown to the user and wanted it to work FAST, yes, PS can do everything, but it's slow to launch 
in this case, we only need to launch a missing explorer where required, VBS is faster for this purpose. This might be my only VBS script on my entire repo :p

<Arguments>/c start /min cscript.exe "\\domain.name.here\NETLOGON\SubFolderForYourStuff\Scripts\Start-Explorer.vbs"</Arguments>
