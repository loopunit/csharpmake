bin\Sharpmake.Application.exe "/sources(@'workspace.sharpmake.cs') /verbose /generateDebugSolutionOnly() /debugSolutionPath(@'out/sharpmake.project')"
IF "%VSINSTALLDIR%"=="" (ECHO VSINSTALLDIR is not defined) ELSE ("%VSINSTALLDIR%\Common7\IDE\devenv.exe" out\sharpmake.project\sharpmake_debugsolution.vs2019.sln)
