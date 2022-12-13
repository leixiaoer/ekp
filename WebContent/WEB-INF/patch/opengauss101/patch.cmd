@ECHO OFF
echo .
echo .
echo                         EKP 的 OpenGauss 支持
echo ===================================================================
echo 本程序仅负责处理和OpenGauss相关的jar文件，其它步骤还需按照文档要求来做。
echo .
echo 确定要执行本程序？
echo . 

SET Choice=
SET /P Choice=选择 Y:执行  N:不执行
IF /I "%Choice%"=="N" GOTO :END
IF /I "%Choice%"=="n" GOTO :END

:PATCH

set EKPLIB=..\..\..\WEB-INF\lib
set WEBINF=%EKPLIB%\..

rem echo WEBINF : %WEBINF%
rem echo EKPLIB : %EKPLIB%
echo %EKPLIB%
del /Q %EKPLIB%\postgre*.jar
copy /Y postgresql4opengauss-1.0.1.jdk8.jar   %EKPLIB%
rem copy /Y *.sign %EKPLIB%

ENDLOCAL

echo .
echo .
echo 程序运行完毕。

:END

pause

