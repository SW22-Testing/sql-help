@ECHO OFF

set /p instance= "Instance serveru: "
set /p database= "Databaze: "
set /p table= "Hledana tabulka: "

REM nastaveni casu
set datetimef=%date:~-4%_%date:~3,2%_%date:~0,2%__%time:~0,2%_%time:~3,2%_%time:~6,2%

REM spusteni sqlcmd
sqlcmd -S %instance% -W -h -1 -Q "set nocount on; select concat(column_name,' (', DATA_TYPE, IIF(character_maximum_length > 0, concat('(',character_maximum_length,')'), ''), ', ', IIF(IS_NULLABLE = 'YES', 'null', 'not null'),')') from %database%.INFORMATION_SCHEMA.COLUMNS where table_name='%table%'; " -o %TEMP%\%datetimef%_result_query.txt

echo.
REM precteni souboru
type %TEMP%\%datetimef%_result_query.txt
echo.

REM smazani tmp souboru
del %TEMP%\%datetimef%_result_query.txt

pause