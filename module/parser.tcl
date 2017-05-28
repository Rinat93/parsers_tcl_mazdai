package require http
package require tls
source core/config/conf.tcl
proc Request {urls} {
    set i 0
    foreach url [ dict get $urls sites]  {
        http::register https 443 [list ::tls::socket -tls1 1]
        set token [http::geturl $url -timeout 100000]
        set status [http::status $token]
        if {$status=="ok"} {
            puts $url
            set DomAll [GetDom $token]  
            save_file $DomAll $url
        }
        puts "Обработан $i сайт"
        incr i
    }
}

proc GetDom {token} {
    set answer [http::data $token]
    set fins [ParserHTML $answer]
    http::cleanup $token
    http::unregister https
    return $fins
}

proc ParserHTML {body} {
    set results "0"
    set regexs [RegexConf $body]
    if {$regexs != ""} {
        return $regexs
    } else {
        return "Не найдено соответствие"
    }
}

# Сохраняем результат
proc save_file {line url} {
    set fo [open "save_parser_file/phone.bak" "a+"]
    # Можем отредактировать запись, обязательно проверьте в файле sites.map
        puts -nonewline $fo "\n $line --url: $url" 
    close $fo
}