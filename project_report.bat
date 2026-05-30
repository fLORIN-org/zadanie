@echo off
chcp 65001 >nul

echo =====================================
echo    Генератор отчета по проекту
echo =====================================
echo.

set /p projectPath=Введите путь к папке проекта: 

if not exist "%projectPath%" (
    echo.
    echo Ошибка! Указанная папка не найдена.
    pause
    exit
)

echo.
echo Папка найдена.
echo Создаю отчет...

if not exist reports (
    mkdir reports
)

set reportFile=reports\report.txt

echo ===================================== > "%reportFile%"
echo ОТЧЕТ ПО ПРОЕКТУ >> "%reportFile%"
echo ===================================== >> "%reportFile%"
echo Дата: %date% >> "%reportFile%"
echo Время: %time% >> "%reportFile%"
echo Пользователь: %USERNAME% >> "%reportFile%"
echo Компьютер: %COMPUTERNAME% >> "%reportFile%"
echo Путь к проекту: %projectPath% >> "%reportFile%"
echo. >> "%reportFile%"

echo ===== Список файлов и папок ===== >> "%reportFile%"
dir "%projectPath%" /s >> "%reportFile%"

echo. >> "%reportFile%"
echo ===== Подсчет файлов и папок ===== >> "%reportFile%"

set fileCount=0
for /f %%i in ('dir "%projectPath%" /a-d /s /b ^| find /c /v ""') do set fileCount=%%i

set folderCount=0
for /f %%i in ('dir "%projectPath%" /ad /s /b ^| find /c /v ""') do set folderCount=%%i

echo Количество файлов: %fileCount% >> "%reportFile%"
echo Количество папок: %folderCount% >> "%reportFile%"

echo. >> "%reportFile%"
echo ===== Файлы нужных расширений ===== >> "%reportFile%"

echo. >> "%reportFile%"
echo Python (.py): >> "%reportFile%"
dir "%projectPath%\*.py" /s /b 2>nul >> "%reportFile%"

echo. >> "%reportFile%"
echo HTML (.html): >> "%reportFile%"
dir "%projectPath%\*.html" /s /b 2>nul >> "%reportFile%"

echo. >> "%reportFile%"
echo CSS (.css): >> "%reportFile%"
dir "%projectPath%\*.css" /s /b 2>nul >> "%reportFile%"

echo. >> "%reportFile%"
echo JavaScript (.js): >> "%reportFile%"
dir "%projectPath%\*.js" /s /b 2>nul >> "%reportFile%"

echo. >> "%reportFile%"
echo TXT (.txt): >> "%reportFile%"
dir "%projectPath%\*.txt" /s /b 2>nul >> "%reportFile%"

echo. >> "%reportFile%"
echo ===== Дополнительная проверка ===== >> "%reportFile%"

if exist "%projectPath%\README.md" (
    echo README.md найден >> "%reportFile%"
) else (
    echo README.md не найден >> "%reportFile%"
)

if exist "%projectPath%\src" (
    echo Папка src найдена >> "%reportFile%"
) else (
    echo Папка src не найдена >> "%reportFile%"
)

if exist "%projectPath%\docs" (
    echo Папка docs найдена >> "%reportFile%"
) else (
    echo Папка docs не найдена >> "%reportFile%"
)

if exist "%projectPath%\tests" (
    echo Папка tests найдена >> "%reportFile%"
) else (
    echo Папка tests не найдена >> "%reportFile%"
)

echo.
echo Отчет успешно создан:
echo %reportFile%
pause