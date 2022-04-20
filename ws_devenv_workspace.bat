IF "%VSINSTALLDIR%"=="" (ECHO VSINSTALLDIR is not defined) ELSE ("%VSINSTALLDIR%\Common7\IDE\devenv.exe" sharpmake_workspace.sln)
