@ECHO OFF
echo .
echo .
echo                         EKP 的 MYSQL 8.0 支持
echo ===================================================================
echo 本程序仅负责处理和MYSQL 8.0相关的jar文件，其它步骤还需按照文档要求来做。
echo .
echo 确定要执行本程序？
echo .

SET Choice=
SET /P Choice=选择 Y:执行  N:不执行
IF /I "%Choice%"=="N" GOTO :END
IF /I "%Choice%"=="n" GOTO :END

:PATCH

set EKPLIB=..\..\..\lib
set WEBINF=%EKPLIB%\..

rem echo WEBINF : %WEBINF%
rem echo EKPLIB : %EKPLIB%

del /Q %EKPLIB%\mysql-connector-java-5.1.19-bin.jar
copy /Y mysql-connector-java-8.0.15.jar   %EKPLIB%
copy /Y *.sign %EKPLIB%

ENDLOCAL

echo .
echo .
echo 程序运行完毕。请务必根据文档完成WAS 7环境的其它配置内容

:END

pause

