python -m venv python_env
python_env\Scripts\activate.bat

git clone https://github.com/ubisoft/Sharpmake.git Sharpmake

REM patch CompileSharpmake.bat so it works with preview vstudio
copy /Y CompileSharpmake.bat.patch Sharpmake\CompileSharpmake.bat 
COLOR

Sharpmake\bootstrap.bat Sharpmake.Main.sharpmake.cs Release net5.0
devenv Sharpmake\Sharpmake.sln /build "Release" /project "Sharpmake.Application"

REM does not work:
REM python Sharpmake\deploy_binaries.py --root-dir .\Sharpmake --config release --target-dir=.\bin\Sharpmake

REM manual alternative:
xcopy /E "Sharpmake\tmp\bin\release\net5.0" "bin\Sharpmake\"

REM clean up:
rm -rf "Sharpmake\.vs"
rm -rf "Sharpmake\Sharpmake.Application\obj"
rm -rf "Sharpmake\Sharpmake.Generators\obj"
rm -rf "Sharpmake\Sharpmake.Platforms\Sharpmake.CommonPlatforms\obj"
rm -rf "Sharpmake\Sharpmake.sln"
rm -rf "Sharpmake\Sharpmake\obj"
rm -rf "Sharpmake\tmp"

python_env\Scripts\deactivate.bat