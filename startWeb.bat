@ECHO off
SETLOCAL ENABLEDELAYEDEXPANSION

::::::::::::::::::::::::::::::::::::::::::
:: Script to start web server
::::::::::::::::::::::::::::::::::::::::::
SET "SCRIPT_HOME=%~dp0"
IF "%SCRIPT_HOME:~-1%"=="\" SET "SCRIPT_HOME=%SCRIPT_HOME:~0,-1%"

::::::::::::::::::::::::::::::::::::::::::
:: Verify JAVA_HOME and version
::::::::::::::::::::::::::::::::::::::::::
IF NOT DEFINED JAVA_HOME (
  ECHO You must define a valid JAVA_HOME environment variable before you run this script.
  GOTO :ERROR
)
SET "PATH=.;%JAVA_HOME%\bin;%PATH%"
FOR /f "tokens=3" %%g IN ('java.exe -version 2^>^&1 ^| FINDSTR.exe /I "version"') DO (
    SET JAVAVER=%%g
)
SET JAVAVER=%JAVAVER:"=%
ECHO Java Version: %JAVAVER%
FOR /F "delims=. tokens=1-3" %%v IN ("!JAVAVER!") DO (
	SET TMPVAR=%%x&SET TMPVAR=!TMPVAR:~-2!
    SET JAVABUILD=!TMPVAR!
    SET JAVAVER=%%v.%%w
	SET /A MINOR=%%w
	ECHO Major: %%v , Minor: %%w, Build: !JAVABUILD!
)
IF %MINOR% LEQ 6 (
  ECHO Java version is too old.  Gradle requires a newer version.
  ECHO.
  GOTO :ERROR
) ELSE (
  ECHO Java version %MINOR% is ok.
)

:::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Warn if Groovy and Gradle aren't installed on system
:::::::::::::::::::::::::::::::::::::::::::::::::::::::
IF NOT DEFINED GRADLE_HOME (
  ECHO WARNING:
  ECHO GRADLE_HOME could be defined as an environment variable and
  ECHO GRADLE_HOME\bin added to your system path.  If Gradle is missing,
  ECHO this script will download and use a wrapper instead.
  ECHO.
  GOTO :END
) ELSE (
  SET "PATH=%PATH%;%GRADLE_HOME%\bin"
)

IF NOT DEFINED GROOVY_HOME (
  ECHO WARNING:
  ECHO You might want to define GROOVY_HOME as an environment variable
  ECHO but this is not required.
  ECHO.
) ELSE (
  SET "PATH=%PATH%;%GROOVY_HOME%\bin"
)

::::::::::::::::::::::::::::::::::::::::::
:: Verify server is not already running
::::::::::::::::::::::::::::::::::::::::::
netstat -an | FIND "8001"
IF %ERRORLEVEL%==1 (
  TITLE BasicHttpServer on port 8001
) ELSE (
  ECHO SERVER ALREADY RUNNING
  ECHO Sometimes ports will take a minute to close after shutting down this HTTP server.
  ECHO.
  GOTO :ERROR
)

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Verify program args contain a valid HTTP root directory
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
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

:::::::::::::::::::::::::::::::::::::::::::::::
:: Verify required class is compiled by wrapper
:::::::::::::::::::::::::::::::::::::::::::::::
SET "BUILD_HOME=%SCRIPT_HOME%\build"
IF NOT EXIST "%BUILD_HOME%\classes\main\webdriver\test\BasicHttpServer.class" (
  ECHO You need to compile BasicHttpServer.java before this will run.
  ECHO Expecting it at: ^"%BUILD_HOME%\classes\main\webdriver\test\BasicHttpServer.class^"
  gradlew.bat copyToLib compileJava
  ECHO Finished compiling.
  timeout 5
)

:::::::::::::::::::::::::::::::::::::::::::::::::
:: Verify required http server libs are available
:::::::::::::::::::::::::::::::::::::::::::::::::
IF NOT EXIST "%SCRIPT_HOME%\lib" (
  ECHO You need to run the ^"copyToLib^" task to create the lib directory.
  ECHO Required to start web server.
  GOTO :ERROR
)

:::::::::::::::::::::::::::::::::::::::::::::::
:: Verify HTTP root directory exists in project
:::::::::::::::::::::::::::::::::::::::::::::::
IF NOT EXIST "site" (
  ECHO The directory ^"site^" does not exist.  Will not run.
  GOTO :ERROR
)

::::::::::::::::::::::::::::::::::::::::::
:: Start server
::::::::::::::::::::::::::::::::::::::::::
SET "CLASSPATH=%SCRIPT_HOME%\lib\*;%BUILD_HOME%\classes\main"
ECHO java.exe -cp %CLASSPATH% webdriver.test.BasicHttpServer "%HTTP_ROOT%" .....
ECHO.
ECHO Starting web server...

java.exe -cp %CLASSPATH% webdriver.test.BasicHttpServer "%HTTP_ROOT%"

GOTO :END
::::::::::::::::::::::::::::::::::::::::::
:: Error
::::::::::::::::::::::::::::::::::::::::::
:ERROR
ECHO Error occurred.
pause

::::::::::::::::::::::::::::::::::::::::::
:: End
::::::::::::::::::::::::::::::::::::::::::
:END
ECHO End of script.  Server stopped.
