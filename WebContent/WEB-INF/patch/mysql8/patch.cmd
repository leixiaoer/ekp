@ECHO OFF
echo .
echo .
echo                         EKP �� MYSQL 8.0 ֧��
echo ===================================================================
echo ��������������MYSQL 8.0��ص�jar�ļ����������軹�谴���ĵ�Ҫ��������
echo .
echo ȷ��Ҫִ�б�����
echo .

SET Choice=
SET /P Choice=ѡ�� Y:ִ��  N:��ִ��
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
echo ����������ϡ�����ظ����ĵ����WAS 7������������������

:END

pause

