@ECHO OFF
echo .
echo .
echo                         EKP �� OpenGauss ֧��
echo ===================================================================
echo ��������������OpenGauss��ص�jar�ļ����������軹�谴���ĵ�Ҫ��������
echo .
echo ȷ��Ҫִ�б�����
echo . 

SET Choice=
SET /P Choice=ѡ�� Y:ִ��  N:��ִ��
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
echo ����������ϡ�

:END

pause

