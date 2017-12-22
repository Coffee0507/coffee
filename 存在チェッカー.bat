@echo off
cls
echo ---------------------------------------------
echo アプリケーション存在チェッカー
echo ---------------------------------------------

rem チェック対象のディレクトリを指定
SET dir="C:\xampp\."

rem ディレクトリが存在するかチェックする
if exist %dir% goto CODE1
if not exist %dir% goto CODE2

rem ディレクトリが存在する場合
:CODE1
echo O XAMPP
goto ECLIPSE

rem ディレクトリが存在しない場合
:CODE2
echo X XAMPP



:ECLIPSE
rem チェック対象のディレクトリを指定
SET dir="C:\pleiades\."

rem ディレクトリが存在するかチェックする
if exist %dir% goto CODE3
if not exist %dir% goto CODE4

rem ディレクトリが存在する場合
:CODE3
echo O ECLIPSE(Pleiades)
goto 7ZIP

rem ディレクトリが存在しない場合
:CODE4
echo X ECLIPSE(Pleiades)


:7ZIP
rem チェック対象のディレクトリを指定
SET dir="C:\Program Files\7-Zip\."

rem ディレクトリが存在するかチェックする
if exist %dir% goto CODE5
if not exist %dir% goto CODE6

rem ディレクトリが存在する場合
:CODE5
echo O 7-ZIP
goto JAVA

rem ディレクトリが存在しない場合
:CODE6
echo X 7-ZIP




:JAVA
rem チェック対象のディレクトリを指定
SET dir="C:\Program Files\Java\."

rem ディレクトリが存在するかチェックする
if exist %dir% goto CODE7
if not exist %dir% goto CODE8

rem ディレクトリが存在する場合
:CODE7
echo O JDK
goto BRACKETS

rem ディレクトリが存在しない場合
:CODE8
echo X JDK


:BRACKETS
rem チェック対象のディレクトリを指定
SET dir="C:\Program Files (x86)\Brackets\."

rem ディレクトリが存在するかチェックする
if exist %dir% goto CODE9
if not exist %dir% goto CODE10

rem ディレクトリが存在する場合
:CODE9
echo O Brackets
goto GIT

rem ディレクトリが存在しない場合
:CODE10
echo X Brackets


:GIT
rem チェック対象のディレクトリを指定
SET dir="C:\Program Files (x86)\Git\."
SET dir2="C:\Program Files\Git\."

rem ディレクトリが存在するかチェックする
if exist %dir% goto CODE11
if exist %dir2% goto CODE11
if not exist %dir% goto CODE12

rem ディレクトリが存在する場合
:CODE11
echo O Git
goto NET45

rem ディレクトリが存在しない場合
:CODE12
echo X Git



:NET45
rem チェック対象のディレクトリを指定
SET dir="C:\Windows\Microsoft.NET\Framework\v4.0.30319\."

rem ディレクトリが存在するかチェックする
if exist %dir% goto CODE13
if not exist %dir% goto CODE14

rem ディレクトリが存在する場合
:CODE13
echo O NET4.0
goto SAKURA

rem ディレクトリが存在しない場合
:CODE14
echo X NET4.0



:SAKURA
rem チェック対象のディレクトリを指定
SET dir="C:\Program Files (x86)\sakura\."

rem ディレクトリが存在するかチェックする
if exist %dir% goto CODE15
if not exist %dir% goto CODE16

rem ディレクトリが存在する場合
:CODE15
echo O SAKURA
goto END
rem ディレクトリが存在しない場合
:CODE16
echo X SAKURA

:END
echo ---------------------------------------------
pause