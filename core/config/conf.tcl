# Конфиг обработки регулярных выражени и их считывания с конфига регексов
proc RegexConf {body} {
    set final ""
    set results "0"
    
    set fp [open "core/config/regex.confi"]
        while {-1 != [gets $fp line]} {
            eval "set new_line $line"
            regexp $new_line $body results
            if {$results != "0"} {
                lappend final $results
            }
        }
    close $fp
    puts $final
    return $final
}