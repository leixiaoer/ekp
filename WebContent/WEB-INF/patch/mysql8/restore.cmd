@ECHO OFF
echo .
echo .
echo                  EKP �� MYSQL 8.0 ��ԭ����
echo ===================================================================
echo   �ó����ȡ��MYSQL 8.0֧�ֳ����������޸ġ�
echo .
echo   ȷ��Ҫִ�б�����

SET Choice=
SET /P Choice=ѡ�� Y:ִ��  N:��ִ��
IF /I "%Choice%"=="N" GOTO :END
IF /I "%Choice%"=="n" GOTO :END

:RESTORE

SETLOCAL

set EKPLIB=..\..\..\lib
set WEBINF=%EKPLIB%\..
set RESTORE=restore

rem echo WEBINF : %WEBINF%
rem echo EKPLIB : %EKPLIB%
rem echo RESTORE: %RESTORE%

del /Q %EKPLIB%\mysql-connector-java-8.0.15.jar
copy /Y %RESTORE%\*.jar  %EKPLIB%
copy /Y %RESTORE%\*.sign %EKPLIB%

ENDLOCAL

echo .
echo .
echo ����������ϡ�����㻹���������޸ģ��������ֶ���ԭ��

:END

pause

