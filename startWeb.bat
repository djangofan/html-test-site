@ECHO off
SETLOCAL ENABLEDELAYEDEXPANSION

IF NOT DEFINED JAVA_HOME (
  ECHO You must define a valid JAVA_HOME environment variable before you run this script.
  GOTO :ERROR
)
SET "PATH=.;%JAVA_HOME%\bin;%PATH%"

netstat -an | FIND "8001"
IF %ERRORLEVEL%==1 (
  TITLE BasicHttpServer on port 8001
) ELSE (
  ECHO SERVER ALREADY RUNNING
  ECHO Sometimes ports will take a minute to close after shutting down this HTTP server.
  GOTO :ERROR
)

SET "SCRIPT_HOME=%~dp0"
IF "%SCRIPT_HOME:~-1%"=="\" SET "SCRIPT_HOME=%SCRIPT_HOME:~0,-1%"

IF "%~1"=="" (
  ECHO Program requires argument of a relative directory that defines
  ECHO the http root directory.  Defaults to current directory.
  ECHO.
  SET "HTTP_ROOT=%SCRIPT_HOME%\site"
) ELSE (
  SET "HTTP_ROOT=%SCRIPT_HOME\%~1"
)
ECHO.
ECHO HTTP_ROOT=%HTTP_ROOT%
ECHO.

SET "BUILD_HOME=%SCRIPT_HOME%\build"
IF NOT EXIST "%BUILD_HOME%\classes\main\webdriver\test\BasicHttpServer.class" (
  ECHO You need to compile BasicHttpServer.java before this will run.
  ECHO Expecting it at: ^"%BUILD_HOME%\classes\main\webdriver\test\BasicHttpServer.class^"
  gradle.bat copyToLib compileJava
  ECHO Finished compiling.  Try script again.
  GOTO :ERROR
)

IF NOT EXIST "%SCRIPT_HOME%\lib" (
  ECHO You need to run the ^"copyToLib^" task to create the lib directory.
  ECHO Required to start web server.
  GOTO :ERROR
)

IF NOT EXIST "site" (
  ECHO The directory ^"site^" does not exist.  Will not run.
  GOTO :ERROR
)

SET "CLASSPATH=%SCRIPT_HOME%\lib\*;%BUILD_HOME%\classes\main"
ECHO java.exe -cp %CLASSPATH% webdriver.test.BasicHttpServer "%HTTP_ROOT%" .....
ECHO.
ECHO Starting web server...

java.exe -cp %CLASSPATH% webdriver.test.BasicHttpServer "%HTTP_ROOT%"

GOTO :END
:ERROR
pause
:END
ECHO End of script.  Server stopped.
