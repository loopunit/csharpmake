REM %~dp0\bin\Sharpmake\Sharpmake.Application.exe %* /generateDebugSolution()
%~dp0\bin\Sharpmake\Sharpmake.Application.exe "/sources(@'workspace.sharpmake.cs') /verbose /generateDebugSolutionOnly() /debugSolutionPath(@'sharpmake.project')"
