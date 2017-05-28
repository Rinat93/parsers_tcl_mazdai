# Добавление новых сайтов в базу парсинга
# Указываем имя домена
set domen "https://test"
#параметры которые имеются для парсинга
set parametrs "id groupid"
# От скольки 
set start 3000
# до
set end 10000
set fo [open "core/config/sites.map" "a+"]
    while {$start < $end} {
        foreach parametr $parametrs {
            # Эта настройка то как ссылки будут записываться, вам нужно будет подредактировать под себя
            puts -nonewline $fo "\n(row)-$domen/type/$parametr/$start$"    
        }
        incr start
    }
close $fo