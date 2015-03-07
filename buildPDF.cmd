@ECHO ON

REM This is based on Scott Hanselman's GetRuby.cmd
REM https://github.com/shanselman/march-is-for-makers/blob/master/getruby.cmd

REM Put Tex in Path
REM You can also use %TEMP% but it is cleared on site restart. Tools is persistent.
SET PATH=%PATH%;D:\home\site\deployments\tools\t\miktex-2.9.5105\miktex\bin

REM I am in the repository folder
pushd D:\home\site\deployments\tools 
if not exist t md t
cd t
if exist miktex-2.9.5105 goto end

echo No LaTeX, need to get it!

REM Get Ruby and Rails
REM 32bit
REM  get miktex portable from http://mirror.jmu.edu/pub/CTAN/systems/win32/miktex/setup/miktex-portable-2.9.5105.exe
curl -o miktex-2.9.5105.exe http://mirror.jmu.edu/pub/CTAN/systems/win32/miktex/setup/miktex-portable-2.9.5105.exe
REM Azure puts 7zip here!
EcHO START Unzipping MikTex
d:\7zip\7za x -y -omiktex-2.9.5105 miktex-2.9.5105.exe > outmiktex
EcHO DONE Unzipping MikTex





:end
popd
REM Build the pdf
pdflatex.exe resume.tex -halt-on-error

REM KuduSync is after this!