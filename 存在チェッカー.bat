@echo off
cls
echo ---------------------------------------------
echo �A�v���P�[�V�������݃`�F�b�J�[
echo ---------------------------------------------

rem �`�F�b�N�Ώۂ̃f�B���N�g�����w��
SET dir="C:\xampp\."

rem �f�B���N�g�������݂��邩�`�F�b�N����
if exist %dir% goto CODE1
if not exist %dir% goto CODE2

rem �f�B���N�g�������݂���ꍇ
:CODE1
echo O XAMPP
goto ECLIPSE

rem �f�B���N�g�������݂��Ȃ��ꍇ
:CODE2
echo X XAMPP



:ECLIPSE
rem �`�F�b�N�Ώۂ̃f�B���N�g�����w��
SET dir="C:\pleiades\."

rem �f�B���N�g�������݂��邩�`�F�b�N����
if exist %dir% goto CODE3
if not exist %dir% goto CODE4

rem �f�B���N�g�������݂���ꍇ
:CODE3
echo O ECLIPSE(Pleiades)
goto 7ZIP

rem �f�B���N�g�������݂��Ȃ��ꍇ
:CODE4
echo X ECLIPSE(Pleiades)


:7ZIP
rem �`�F�b�N�Ώۂ̃f�B���N�g�����w��
SET dir="C:\Program Files\7-Zip\."

rem �f�B���N�g�������݂��邩�`�F�b�N����
if exist %dir% goto CODE5
if not exist %dir% goto CODE6

rem �f�B���N�g�������݂���ꍇ
:CODE5
echo O 7-ZIP
goto JAVA

rem �f�B���N�g�������݂��Ȃ��ꍇ
:CODE6
echo X 7-ZIP




:JAVA
rem �`�F�b�N�Ώۂ̃f�B���N�g�����w��
SET dir="C:\Program Files\Java\."

rem �f�B���N�g�������݂��邩�`�F�b�N����
if exist %dir% goto CODE7
if not exist %dir% goto CODE8

rem �f�B���N�g�������݂���ꍇ
:CODE7
echo O JDK
goto BRACKETS

rem �f�B���N�g�������݂��Ȃ��ꍇ
:CODE8
echo X JDK


:BRACKETS
rem �`�F�b�N�Ώۂ̃f�B���N�g�����w��
SET dir="C:\Program Files (x86)\Brackets\."

rem �f�B���N�g�������݂��邩�`�F�b�N����
if exist %dir% goto CODE9
if not exist %dir% goto CODE10

rem �f�B���N�g�������݂���ꍇ
:CODE9
echo O Brackets
goto GIT

rem �f�B���N�g�������݂��Ȃ��ꍇ
:CODE10
echo X Brackets


:GIT
rem �`�F�b�N�Ώۂ̃f�B���N�g�����w��
SET dir="C:\Program Files (x86)\Git\."
SET dir2="C:\Program Files\Git\."

rem �f�B���N�g�������݂��邩�`�F�b�N����
if exist %dir% goto CODE11
if exist %dir2% goto CODE11
if not exist %dir% goto CODE12

rem �f�B���N�g�������݂���ꍇ
:CODE11
echo O Git
goto NET45

rem �f�B���N�g�������݂��Ȃ��ꍇ
:CODE12
echo X Git



:NET45
rem �`�F�b�N�Ώۂ̃f�B���N�g�����w��
SET dir="C:\Windows\Microsoft.NET\Framework\v4.0.30319\."

rem �f�B���N�g�������݂��邩�`�F�b�N����
if exist %dir% goto CODE13
if not exist %dir% goto CODE14

rem �f�B���N�g�������݂���ꍇ
:CODE13
echo O NET4.0
goto SAKURA

rem �f�B���N�g�������݂��Ȃ��ꍇ
:CODE14
echo X NET4.0



:SAKURA
rem �`�F�b�N�Ώۂ̃f�B���N�g�����w��
SET dir="C:\Program Files (x86)\sakura\."

rem �f�B���N�g�������݂��邩�`�F�b�N����
if exist %dir% goto CODE15
if not exist %dir% goto CODE16

rem �f�B���N�g�������݂���ꍇ
:CODE15
echo O SAKURA
goto END
rem �f�B���N�g�������݂��Ȃ��ꍇ
:CODE16
echo X SAKURA

:END
echo ---------------------------------------------
pause