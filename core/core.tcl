# source core/config/conf.tcl
namespace eval Core {
    proc Core {} {
        file_parser
    }
    # Парсер самописной БД
    proc file_parser {} {
        # Открываем файл *.map
        set fp [open "core/config/sites.map" r]
            set file_data [read $fp]
            # Каждый пробел является "Новой строкой"
            foreach line $file_data {
                set line_old $line
                # Ищем столбцы
                set search_col [regexp {(\[[a-zA-Z0-9]*\])} $line -> column]
                # ищем стобцы
                if {$search_col != 0} {
                    set xyz [regexp {([a-zA-Z0-9].*[a-zA-Z0-9])} $line -> columns]
                } else {
                    # Ищем строки в столбце
                    set search_rows [regexp {\([a-z]*\)-[a-z].*\$} $line row]
                    if {$search_rows} {
                        DictSave $columns $row
                    }
                }
            }
        close $fp
    }
    # Сохраняем все в словарь
    proc DictSave { columns line } {
        global dict_database
        # Убираем с строк ненужные символы
        regexp {h.*[a-zA-Z0-9]?\/*[0-9]|www.*[a-zA-Z0-9]?\/*[0-9]} $line rows
        dict lappend dict_database $columns $rows
    }
}