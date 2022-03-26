python -m venv python_env
python_env\Scripts\activate.bat

REM git clone https://github.com/ubisoft/Sharpmake.git Sharpmake
REM 
REM REM patch CompileSharpmake.bat so it works with preview vstudio
REM copy /Y CompileSharpmake.bat.patch Sharpmake\CompileSharpmake.bat 
REM COLOR
REM 
REM Sharpmake\bootstrap.bat Sharpmake.Main.sharpmake.cs Release net5.0
REM devenv Sharpmake\Sharpmake.sln /build "Release" /project "Sharpmake.Application"
REM 
REM REM does not work:
REM REM python Sharpmake\deploy_binaries.py --root-dir .\Sharpmake --config release --target-dir=.\bin\Sharpmake
REM 
REM REM manual alternative:
REM xcopy /E "Sharpmake\tmp\bin\release\net5.0" "bin\Sharpmake\"
REM 
REM REM clean up:
REM rm -rf "Sharpmake\.vs"
REM rm -rf "Sharpmake\Sharpmake.Application\obj"
REM rm -rf "Sharpmake\Sharpmake.Generators\obj"
REM rm -rf "Sharpmake\Sharpmake.Platforms\Sharpmake.CommonPlatforms\obj"
REM rm -rf "Sharpmake\Sharpmake.sln"
REM rm -rf "Sharpmake\Sharpmake\obj"
REM rm -rf "Sharpmake\tmp"

python_env\Scripts\deactivate.bat