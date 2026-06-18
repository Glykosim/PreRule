@echo off
setlocal

where git >nul 2>nul
if errorlevel 1 (
  echo Git was not found. Install Git and try again.
  pause
  exit /b 1
)

set "MESSAGE=%~1"
if "%MESSAGE%"=="" set "MESSAGE=Update project"

git status --short
git add -A
git diff --cached --quiet
if not errorlevel 1 (
  echo No changes to commit.
) else (
  git commit -m "%MESSAGE%"
  if errorlevel 1 (
    echo Commit failed.
    pause
    exit /b 1
  )
)

for /f "delims=" %%b in ('git branch --show-current') do set "BRANCH=%%b"
git push -u origin "%BRANCH%"
if errorlevel 1 (
  echo Push failed. Check GitHub login/permissions and try again.
  pause
  exit /b 1
)

echo Done.
pause
