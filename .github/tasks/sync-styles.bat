@echo off
echo.


SET /p confirm= ^> Sincronizar actual?(Y/N):

if "%confirm%"=="Y" goto current
if "%confirm%"=="N" goto general

:current
for /f %%i in ('git branch --show-current') do set lastBranch=%%i
echo %lastBranch%

:general
::u/components
git checkout --quiet u/components
git stash push
git merge -m "Sync config" --quiet u/styles 

::u/master
git checkout --quiet master
git stash push
git merge -m "Sync config" --quiet u/styles

::return
git checkout %lastBranch%
echo .
echo Recuerda bajar los cambios del stash en cada rama 
pause
cls
    