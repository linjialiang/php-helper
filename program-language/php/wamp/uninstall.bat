@echo off
mode con cols=120 lines=40
>NUL 2>&1 REG.exe query "HKU\S-1-5-19" || (
    ECHO SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\Getadmin.vbs"
    ECHO UAC.ShellExecute "%~f0", "%1", "", "runas", 1 >> "%TEMP%\Getadmin.vbs"
    "%TEMP%\Getadmin.vbs"
    DEL /f /q "%TEMP%\Getadmin.vbs" 2>NUL
    Exit /b
)
:HomeMenu
Cls
@ echo.
@ echo.　　           【菜单选项】
@ echo.
@ echo.             卸载 → 请输入1
@ echo.
@ echo.             极速卸载 → 请输入2
@ echo.
@ echo.             退出 → 请输入0
@ echo.
@ echo.             提示：如果只是推荐安装的话，我们选择极速卸载即可！
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" Goto Uninstall
if /i "%export%"=="2" Goto SpeedUninstall
if /i "%export%"=="0" exit
@ echo.
@ echo              选择无效，请重新输入
ping -n 2 127.1>nul
Goto HomeMenu
:Uninstall
Goto SelectDigit
:SelectDigit
Cls
@ echo.
@ echo.              【位数选项】
@ echo.
@ echo.             64位 → 请输入1
@ echo.
@ echo.             32位 → 请输入2
@ echo.
@ echo.             退出 → 请输入0
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" set Digit=64
if /i "%export%"=="1" set ServiceHttpd=apache24
if /i "%export%"=="1" set ServiceMySQL=mysql
if /i "%export%"=="1" Goto IfHttpd
if /i "%export%"=="2" set Digit=32
if /i "%export%"=="2" set ServiceHttpd=httpd
if /i "%export%"=="2" set ServiceMySQL=mariadb
if /i "%export%"=="2" Goto IfHttpd
if /i "%export%"=="3" Goto HomeMenu
if /i "%export%"=="0" exit
@ echo.
@ echo              选择无效，请重新输入
ping -n 2 127.1>nul
Goto SelectDigit
:IfHttpd
Cls
@ echo.
@ echo.　　　      【是否卸载%Digit%位的%ServiceHttpd%】
@ echo.
@ echo.             确定卸载 → 请输入1
@ echo.
@ echo.             跳过卸载 → 请输入2
@ echo.
@ echo.             重新选择位数 → 请输入3
@ echo.
@ echo.             退出 → 请输入0
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" Goto ReturnHttpd
if /i "%export%"=="2" Goto SelecteMySQL
if /i "%export%"=="3" Goto SelectDigit
if /i "%export%"=="0" exit
@ echo.
echo                选择无效，请重新输入
ping -n 2 127.1>nul
Goto IfHttpd
:SelecteMySQL
Cls
@ echo.
@ echo.　　　　       【选择%Digit%位的mariadb版本】
@ echo.
@ echo.             mariadb 10.3 → 请输入1
@ echo.
@ echo.             mariadb 10.2 → 请输入2
@ echo.
@ echo.             mariadb 10.1 → 请输入3
@ echo.
@ echo.             mariadb 10.0 → 请输入4
@ echo.
@ echo.             退出 → 请输入0
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" SET MySQLVersion=103
if /i "%export%"=="1" Goto IfMySQL
if /i "%export%"=="2" SET MySQLVersion=102
if /i "%export%"=="2" Goto IfMySQL
if /i "%export%"=="3" SET MySQLVersion=101
if /i "%export%"=="3" Goto IfMySQL
if /i "%export%"=="4" SET MySQLVersion=100
if /i "%export%"=="4" Goto IfMySQL
if /i "%export%"=="0" exit
@ echo.
@ echo              选择无效，请重新输入
ping -n 2 127.1>nul
Goto SelecteMySQL
:IfMySQL
Cls
@ echo.
@ echo.　　　      【是否卸载%Digit%位的%ServiceMySQL%%MySQLVersion%】
@ echo.
@ echo.             确定卸载 → 请输入1
@ echo.
@ echo.             取消卸载 → 请输入2
@ echo.
@ echo.             重选mariadb版本 → 请输入3
@ echo.
@ echo.             退出 → 请输入0
@ echo.
set /p export=      输入数字按回车：
if /i "%export%"=="1" Goto ReturnMySQL
if /i "%export%"=="2" exit
if /i "%export%"=="3" Goto SelecteMySQL
if /i "%export%"=="0" exit
@ echo.
echo                选择无效，请重新输入
ping -n 2 127.1>nul
Goto IfMySQL
:ReturnHttpd
Cls
@ echo.
@ echo              将%ServiceHttpd%从系统服务卸载...
@ c:
@ cd c:\wamp\%Digit%\apache24\bin\
@ net stop %ServiceHttpd%
@ httpd.exe -k uninstall -n %ServiceHttpd%
@ echo.
@ echo              %ServiceHttpd%卸载成功！即将进入mariadb卸载界面...
ping -n 2 127.1>nul
Goto SelecteMySQL
:ReturnMySQL
Cls
@ echo.
@ echo              将%ServiceMySQL%%MySQLVersion%从系统服务卸载...
@ cd c:\wamp\%Digit%\mariadb%MySQLVersion%\bin\
@ net stop %ServiceMySQL%%MySQLVersion%
@ mysqld.exe --remove %ServiceMySQL%%MySQLVersion% --defaults-file=c:\wamp\conf\my.ini
@ echo.
@ echo              卸载%ServiceMySQL%%MySQLVersion%成功！3秒后退出脚本...
ping -n 3 127.1>nul
Goto HomeMenu
:SpeedUninstall
Cls
set Digit=64
set ServiceHttpd=apache24
set MySQLVersion=103
set ServiceMySQL=mysql
@ echo.
@ echo              将%ServiceHttpd%从系统服务卸载...
@ c:
@ cd c:\wamp\%Digit%\apache24\bin\
@ httpd.exe -k uninstall -n %ServiceHttpd%
@ echo.
@ echo              %ServiceHttpd%卸载成功！
ping -n 2 127.1>nul
@ echo.
@ echo              将%ServiceMySQL%%MySQLVersion%从系统服务卸载...
@ cd c:\wamp\%Digit%\mariadb%MySQLVersion%\bin\
@ mysqld.exe --remove %ServiceMySQL%%MySQLVersion% --defaults-file=c:\wamp\conf\my.ini
@ echo.
@ echo              卸载%ServiceMySQL%%MySQLVersion%成功！3秒后退出脚本...
ping -n 3 127.1>nul
exit