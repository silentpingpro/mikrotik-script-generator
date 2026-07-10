:local token "8719159938:AAGUwJQvtktFVTyYUAREocU4ZBOTIcTW5z0"
:local chatid "7309499992"
:local offset 1
:local api "https://api.telegram.org/bot"

:local ifname [/interface bridge find where name~"tg-offset-"]
:if ([:len $ifname] > 0) do={
    :local fullname [/interface bridge get $ifname name]
    :set offset [:tonum [:pick $fullname 10 [:len $fullname]]]
}

:local fetchErr 0
:do { /tool fetch url=($api . $token . "/getUpdates?offset=" . $offset . "&timeout=0") keep-result=yes dst-path=tg-updates.txt } on-error={ :set fetchErr 1 }
:if ($fetchErr != 0) do={ :return }
:local data ""
:do { :set data [/file get tg-updates.txt contents] } on-error={ :set data "" }
:if ([:len $data] = 0) do={ :return }
:local replied false
:local cdata ""
:local msgtext ""
:local isCallback false

:if ([:find $data "callback_query"] > 0) do={
    :set isCallback true
    :local ds ([:find $data "\"data\":\""]+8)
    :local de [:find $data "\"" $ds]
    :set cdata [:pick $data $ds $de]
}

:if ($isCallback=false) do={
    :if ([:find $data "\"text\":\""] > 0) do={
        :local ts ([:find $data "\"text\":\""]+8)
        :local te [:find $data "\"" $ts]
        :set msgtext [:pick $data $ts $te]
    }
}

:local mainKbd "%7B%22inline_keyboard%22%3A%5B%5B%7B%22text%22%3A%22%F0%9F%93%8A%20%D9%88%D8%B6%D8%B9%DB%8C%D8%AA%20%DA%A9%D9%84%20%D8%B4%D8%A8%DA%A9%D9%87%22%2C%22callback_data%22%3A%22status_all%22%7D%5D%2C%5B%7B%22text%22%3A%22%F0%9F%96%A5%EF%B8%8F%20%D9%88%D8%B6%D8%B9%DB%8C%D8%AA%2F%D8%AA%D8%BA%DB%8C%DB%8C%D8%B1%20%D8%B3%D8%B1%D9%88%D8%B1%D9%87%D8%A7%22%2C%22callback_data%22%3A%22server_menu%22%7D%5D%2C%5B%7B%22text%22%3A%22%F0%9F%8C%90%20%D8%A2%D8%AF%D8%B1%D8%B3%20IP%22%2C%22callback_data%22%3A%22ip%22%7D%2C%7B%22text%22%3A%22%E2%8F%B1%EF%B8%8F%20%D8%A2%D9%BE%D8%AA%D8%A7%DB%8C%D9%85%22%2C%22callback_data%22%3A%22uptime%22%7D%5D%5D%7D"
:local srvMenuKbd "%7B%22inline_keyboard%22%3A%5B%5B%7B%22text%22%3A%22Server%20S1%22%2C%22callback_data%22%3A%22srv_1%22%7D%2C%7B%22text%22%3A%22Server%20S2%22%2C%22callback_data%22%3A%22srv_2%22%7D%2C%7B%22text%22%3A%22Server%20S3%22%2C%22callback_data%22%3A%22srv_3%22%7D%2C%7B%22text%22%3A%22Server%20S4%22%2C%22callback_data%22%3A%22srv_4%22%7D%5D%2C%5B%7B%22text%22%3A%22Server%20S5%22%2C%22callback_data%22%3A%22srv_5%22%7D%2C%7B%22text%22%3A%22Server%20S6%22%2C%22callback_data%22%3A%22srv_6%22%7D%2C%7B%22text%22%3A%22Server%20S7%22%2C%22callback_data%22%3A%22srv_7%22%7D%5D%2C%5B%7B%22text%22%3A%22%F0%9F%94%99%20%D8%A8%D8%A7%D8%B2%DA%AF%D8%B4%D8%AA%20%D8%A8%D9%87%20%D9%85%D9%86%D9%88%DB%8C%20%D8%A7%D8%B5%D9%84%DB%8C%22%2C%22callback_data%22%3A%22main_menu%22%7D%5D%5D%7D"
:local ctrlKbd1 "%7B%22inline_keyboard%22%3A%5B%5B%7B%22text%22%3A%22%F0%9F%93%8A%20%D9%88%D8%B6%D8%B9%DB%8C%D8%AA%22%2C%22callback_data%22%3A%22srv_status_1%22%7D%2C%7B%22text%22%3A%22%E2%96%B6%EF%B8%8F%20%D9%81%D8%B9%D8%A7%D9%84%22%2C%22callback_data%22%3A%22srv_enable_1%22%7D%2C%7B%22text%22%3A%22%E2%8F%B8%EF%B8%8F%20%D8%BA%DB%8C%D8%B1%D9%81%D8%B9%D8%A7%D9%84%22%2C%22callback_data%22%3A%22srv_disable_1%22%7D%5D%2C%5B%7B%22text%22%3A%22%F0%9F%94%99%20%D8%A8%D8%A7%D8%B2%DA%AF%D8%B4%D8%AA%20%D8%A8%D9%87%20%D8%B3%D8%B1%D9%88%D8%B1%D9%87%D8%A7%22%2C%22callback_data%22%3A%22server_menu%22%7D%5D%5D%7D"
:local ctrlKbd2 "%7B%22inline_keyboard%22%3A%5B%5B%7B%22text%22%3A%22%F0%9F%93%8A%20%D9%88%D8%B6%D8%B9%DB%8C%D8%AA%22%2C%22callback_data%22%3A%22srv_status_2%22%7D%2C%7B%22text%22%3A%22%E2%96%B6%EF%B8%8F%20%D9%81%D8%B9%D8%A7%D9%84%22%2C%22callback_data%22%3A%22srv_enable_2%22%7D%2C%7B%22text%22%3A%22%E2%8F%B8%EF%B8%8F%20%D8%BA%DB%8C%D8%B1%D9%81%D8%B9%D8%A7%D9%84%22%2C%22callback_data%22%3A%22srv_disable_2%22%7D%5D%2C%5B%7B%22text%22%3A%22%F0%9F%94%99%20%D8%A8%D8%A7%D8%B2%DA%AF%D8%B4%D8%AA%20%D8%A8%D9%87%20%D8%B3%D8%B1%D9%88%D8%B1%D9%87%D8%A7%22%2C%22callback_data%22%3A%22server_menu%22%7D%5D%5D%7D"
:local ctrlKbd3 "%7B%22inline_keyboard%22%3A%5B%5B%7B%22text%22%3A%22%F0%9F%93%8A%20%D9%88%D8%B6%D8%B9%DB%8C%D8%AA%22%2C%22callback_data%22%3A%22srv_status_3%22%7D%2C%7B%22text%22%3A%22%E2%96%B6%EF%B8%8F%20%D9%81%D8%B9%D8%A7%D9%84%22%2C%22callback_data%22%3A%22srv_enable_3%22%7D%2C%7B%22text%22%3A%22%E2%8F%B8%EF%B8%8F%20%D8%BA%DB%8C%D8%B1%D9%81%D8%B9%D8%A7%D9%84%22%2C%22callback_data%22%3A%22srv_disable_3%22%7D%5D%2C%5B%7B%22text%22%3A%22%F0%9F%94%99%20%D8%A8%D8%A7%D8%B2%DA%AF%D8%B4%D8%AA%20%D8%A8%D9%87%20%D8%B3%D8%B1%D9%88%D8%B1%D9%87%D8%A7%22%2C%22callback_data%22%3A%22server_menu%22%7D%5D%5D%7D"
:local ctrlKbd4 "%7B%22inline_keyboard%22%3A%5B%5B%7B%22text%22%3A%22%F0%9F%93%8A%20%D9%88%D8%B6%D8%B9%DB%8C%D8%AA%22%2C%22callback_data%22%3A%22srv_status_4%22%7D%2C%7B%22text%22%3A%22%E2%96%B6%EF%B8%8F%20%D9%81%D8%B9%D8%A7%D9%84%22%2C%22callback_data%22%3A%22srv_enable_4%22%7D%2C%7B%22text%22%3A%22%E2%8F%B8%EF%B8%8F%20%D8%BA%DB%8C%D8%B1%D9%81%D8%B9%D8%A7%D9%84%22%2C%22callback_data%22%3A%22srv_disable_4%22%7D%5D%2C%5B%7B%22text%22%3A%22%F0%9F%94%99%20%D8%A8%D8%A7%D8%B2%DA%AF%D8%B4%D8%AA%20%D8%A8%D9%87%20%D8%B3%D8%B1%D9%88%D8%B1%D9%87%D8%A7%22%2C%22callback_data%22%3A%22server_menu%22%7D%5D%5D%7D"
:local ctrlKbd5 "%7B%22inline_keyboard%22%3A%5B%5B%7B%22text%22%3A%22%F0%9F%93%8A%20%D9%88%D8%B6%D8%B9%DB%8C%D8%AA%22%2C%22callback_data%22%3A%22srv_status_5%22%7D%2C%7B%22text%22%3A%22%E2%96%B6%EF%B8%8F%20%D9%81%D8%B9%D8%A7%D9%84%22%2C%22callback_data%22%3A%22srv_enable_5%22%7D%2C%7B%22text%22%3A%22%E2%8F%B8%EF%B8%8F%20%D8%BA%DB%8C%D8%B1%D9%81%D8%B9%D8%A7%D9%84%22%2C%22callback_data%22%3A%22srv_disable_5%22%7D%5D%2C%5B%7B%22text%22%3A%22%F0%9F%94%99%20%D8%A8%D8%A7%D8%B2%DA%AF%D8%B4%D8%AA%20%D8%A8%D9%87%20%D8%B3%D8%B1%D9%88%D8%B1%D9%87%D8%A7%22%2C%22callback_data%22%3A%22server_menu%22%7D%5D%5D%7D"
:local ctrlKbd6 "%7B%22inline_keyboard%22%3A%5B%5B%7B%22text%22%3A%22%F0%9F%93%8A%20%D9%88%D8%B6%D8%B9%DB%8C%D8%AA%22%2C%22callback_data%22%3A%22srv_status_6%22%7D%2C%7B%22text%22%3A%22%E2%96%B6%EF%B8%8F%20%D9%81%D8%B9%D8%A7%D9%84%22%2C%22callback_data%22%3A%22srv_enable_6%22%7D%2C%7B%22text%22%3A%22%E2%8F%B8%EF%B8%8F%20%D8%BA%DB%8C%D8%B1%D9%81%D8%B9%D8%A7%D9%84%22%2C%22callback_data%22%3A%22srv_disable_6%22%7D%5D%2C%5B%7B%22text%22%3A%22%F0%9F%94%99%20%D8%A8%D8%A7%D8%B2%DA%AF%D8%B4%D8%AA%20%D8%A8%D9%87%20%D8%B3%D8%B1%D9%88%D8%B1%D9%87%D8%A7%22%2C%22callback_data%22%3A%22server_menu%22%7D%5D%5D%7D"
:local ctrlKbd7 "%7B%22inline_keyboard%22%3A%5B%5B%7B%22text%22%3A%22%F0%9F%93%8A%20%D9%88%D8%B6%D8%B9%DB%8C%D8%AA%22%2C%22callback_data%22%3A%22srv_status_7%22%7D%2C%7B%22text%22%3A%22%E2%96%B6%EF%B8%8F%20%D9%81%D8%B9%D8%A7%D9%84%22%2C%22callback_data%22%3A%22srv_enable_7%22%7D%2C%7B%22text%22%3A%22%E2%8F%B8%EF%B8%8F%20%D8%BA%DB%8C%D8%B1%D9%81%D8%B9%D8%A7%D9%84%22%2C%22callback_data%22%3A%22srv_disable_7%22%7D%5D%2C%5B%7B%22text%22%3A%22%F0%9F%94%99%20%D8%A8%D8%A7%D8%B2%DA%AF%D8%B4%D8%AA%20%D8%A8%D9%87%20%D8%B3%D8%B1%D9%88%D8%B1%D9%87%D8%A7%22%2C%22callback_data%22%3A%22server_menu%22%7D%5D%5D%7D"
:local srvNames {"";"Server+S1";"Server+S2";"Server+S3";"Server+S4";"Server+S5";"Server+S6";"Server+S7"}

:if (($msgtext = "/start") || ($msgtext = "/menu")) do={
    /tool fetch url=($api . $token . "/sendMessage?chat_id=" . $chatid . "&text=%F0%9F%93%A1+%D9%BE%D9%86%D9%84+%DA%A9%D9%86%D8%AA%D8%B1%D9%84+MikroTik&reply_markup=" . $mainKbd) keep-result=no
    :set replied true
}

:if (($msgtext = "/status") && ($replied=false)) do={
    :local msg "%F0%9F%93%8A+Status:%0A"
    :global FlagResult
    :foreach idx in={1;2;3;4;5;6;7} do={
        :local ifn ("l2tp-out" . $idx)
        :local nm ($srvNames->$idx)
        :local ifid [/interface find name=$ifn]
        :local r false
        :if ([:len $ifid] > 0) do={ :set r [/interface get $ifid running] }
        :if ($r=true) do={
		
            :global GeoIPIface
			:global PublicIPGlobal
            :set GeoIPIface $ifn
			:set PublicIPGlobal ""
			:set FlagResult ""
				
		   /system script run get-country
            :set msg ($msg . $nm . "+" . $FlagResult . "+%E2%9C%85+UP%0A")
        }
        :if ($r=false) do={ :set msg ($msg . $nm . "+%E2%9D%8C+DOWN%0A") }
    }
    /tool fetch url=($api . $token . "/sendMessage?chat_id=" . $chatid . "&text=" . $msg . "&reply_markup=" . $mainKbd) keep-result=no
    :set replied true
}

:if (($msgtext = "/uptime") && ($replied=false)) do={
    :local uptime [/system resource get uptime]
    :local msg ("%F0%9F%95%90+Uptime:+" . $uptime)
    /tool fetch url=($api . $token . "/sendMessage?chat_id=" . $chatid . "&text=" . $msg . "&reply_markup=" . $mainKbd) keep-result=no
    :set replied true
}

:if (($msgtext = "/ip") && ($replied=false)) do={
    :local msg "%F0%9F%8C%90+IP:%0A"
    :global FlagResult
    :foreach idx in={1;2;3;4;5;6;7} do={
        :local ifn ("l2tp-out" . $idx)
        :local nm ($srvNames->$idx)
        :local ifid [/interface find name=$ifn]
        :local r false
        :if ([:len $ifid] > 0) do={ :set r [/interface get $ifid running] }
        :if ($r=true) do={
		
		
            :global GeoIPIface
			:global PublicIPGlobal
            :set GeoIPIface $ifn
			:set PublicIPGlobal ""
			:set FlagResult ""
			
			
                        /system script run get-country
            :global PublicIPGlobal
   
   :local iip $PublicIPGlobal

:if ([:len $iip] = 0) do={
    :set iip "Unknown"
}

:set msg ($msg . $nm . "+" . $FlagResult . ":+" . $iip . "%0A")


            }
			 :if ($r=false) do={ :set msg ($msg . $nm . "+%E2%9D%8C+DOWN%0A")  }
    }
    /tool fetch url=($api . $token . "/sendMessage?chat_id=" . $chatid . "&text=" . $msg . "&reply_markup=" . $mainKbd) keep-result=no
    :set replied true
}

:if ($isCallback=true) do={

    :if ($cdata = "main_menu") do={
        /tool fetch url=($api . $token . "/sendMessage?chat_id=" . $chatid . "&text=%F0%9F%93%A1+%D9%BE%D9%86%D9%84+%DA%A9%D9%86%D8%AA%D8%B1%D9%84+MikroTik&reply_markup=" . $mainKbd) keep-result=no
    }

    :if ($cdata = "status_all") do={
        :local msg "%F0%9F%93%8A+Status:%0A"
        :global FlagResult
        :foreach idx in={1;2;3;4;5;6;7} do={
            :local ifn ("l2tp-out" . $idx)
            :local nm ($srvNames->$idx)
            :local ifid [/interface find name=$ifn]
            :local r false
            :if ([:len $ifid] > 0) do={ :set r [/interface get $ifid running] }
            :if ($r=true) do={
			
                :global GeoIPIface
                :set GeoIPIface $ifn
				:global PublicIPGlobal
                :set PublicIPGlobal ""
                :set FlagResult ""
                /system script run get-country
                :set msg ($msg . $nm . "+" . $FlagResult . "+%E2%9C%85+UP%0A")
            }
            :if ($r=false) do={ :set msg ($msg . $nm . "+%E2%9D%8C+DOWN%0A") }
        }
        /tool fetch url=($api . $token . "/sendMessage?chat_id=" . $chatid . "&text=" . $msg . "&reply_markup=" . $mainKbd) keep-result=no
    }

    :if ($cdata = "server_menu") do={
        /tool fetch url=($api . $token . "/sendMessage?chat_id=" . $chatid . "&text=%F0%9F%96%A5%EF%B8%8F+%D8%B3%D8%B1%D9%88%D8%B1%D9%87%D8%A7%3A&reply_markup=" . $srvMenuKbd) keep-result=no
    }

    :foreach idx in={1;2;3;4;5;6;7} do={
        :local ifn ("l2tp-out" . $idx)
        :local nm ($srvNames->$idx)
        :local ctrlK ""
        :if ($idx=1) do={ :set ctrlK $ctrlKbd1 }
        :if ($idx=2) do={ :set ctrlK $ctrlKbd2 }
        :if ($idx=3) do={ :set ctrlK $ctrlKbd3 }
        :if ($idx=4) do={ :set ctrlK $ctrlKbd4 }
        :if ($idx=5) do={ :set ctrlK $ctrlKbd5 }
        :if ($idx=6) do={ :set ctrlK $ctrlKbd6 }
        :if ($idx=7) do={ :set ctrlK $ctrlKbd7 }

        :if ($cdata = ("srv_" . $idx)) do={
            :global FlagResult
            :set FlagResult ""
            :local ifid [/interface find name=$ifn]
            :local r false
            :if ([:len $ifid] > 0) do={ :set r [/interface get $ifid running] }
            :if ($r=true) do={
               :global GeoIPIface
                :set GeoIPIface $ifn
				:global PublicIPGlobal
                :set PublicIPGlobal ""
                :set FlagResult ""
                /system script run get-country
            }
            :local msg ($nm . "+%28" . $ifn . "%29%3A%0A")
            :if ($r=true) do={ :set msg ($msg . $FlagResult . "+%E2%9C%85+UP") }
            :if ($r=false) do={ :set msg ($msg . "%E2%9D%8C+DOWN") }
            /tool fetch url=($api . $token . "/sendMessage?chat_id=" . $chatid . "&text=" . $msg . "&reply_markup=" . $ctrlK) keep-result=no
        }

        :if ($cdata = ("srv_status_" . $idx)) do={
            :global FlagResult
            :set FlagResult ""
            :local ifid [/interface find name=$ifn]
            :local r false
            :if ([:len $ifid] > 0) do={ :set r [/interface get $ifid running] }
            :if ($r=true) do={
                :global GeoIPIface
                :set GeoIPIface $ifn
				:global PublicIPGlobal
                :set PublicIPGlobal ""
                :set FlagResult ""
                /system script run get-country
            }
            :local msg ($nm . "+%D9%88%D8%B6%D8%B9%DB%8C%D8%AA%3A%0A")
            :if ($r=true) do={ :set msg ($msg . $FlagResult . "+%E2%9C%85+UP") }
            :if ($r=false) do={ :set msg ($msg . "%E2%9D%8C+DOWN") }
            /tool fetch url=($api . $token . "/sendMessage?chat_id=" . $chatid . "&text=" . $msg . "&reply_markup=" . $ctrlK) keep-result=no
        }

        :if ($cdata = ("srv_enable_" . $idx)) do={
            :local ifid [/interface find name=$ifn]
            :if ([:len $ifid] > 0) do={ /interface enable $ifid }
            :local msg ($nm . "+%E2%96%B6%EF%B8%8F+%D9%81%D8%B9%D8%A7%D9%84+%D8%B4%D8%AF")
            :if ([:len $ifid] = 0) do={ :set msg ($nm . "+%E2%9D%8C+Not+found") }
            /tool fetch url=($api . $token . "/sendMessage?chat_id=" . $chatid . "&text=" . $msg . "&reply_markup=" . $ctrlK) keep-result=no
        }

        :if ($cdata = ("srv_disable_" . $idx)) do={
            :local ifid [/interface find name=$ifn]
            :if ([:len $ifid] > 0) do={ /interface disable $ifid }
            :local msg ($nm . "+%E2%8F%B8%EF%B8%8F+%D8%BA%DB%8C%D8%B1%D9%81%D8%B9%D8%A7%D9%84+%D8%B4%D8%AF")
            :if ([:len $ifid] = 0) do={ :set msg ($nm . "+%E2%9D%8C+Not+found") }
            /tool fetch url=($api . $token . "/sendMessage?chat_id=" . $chatid . "&text=" . $msg . "&reply_markup=" . $ctrlK) keep-result=no
        }
    }
	
	
	
	

    :if ($cdata = "ip") do={
        :local msg "%F0%9F%8C%90+IP:%0A"
        :global FlagResult
        :foreach idx in={1;2;3;4;5;6;7} do={
            :local ifn ("l2tp-out" . $idx)
            :local nm ($srvNames->$idx)
            :local ifid [/interface find name=$ifn]
            :local r false
            :if ([:len $ifid] > 0) do={ :set r [/interface get $ifid running] }
            :if ($r=true) do={
			
                :global GeoIPIface
                :set GeoIPIface $ifn
				:global PublicIPGlobal
                :set PublicIPGlobal ""
                :set FlagResult ""
                /system script run get-country
				
                :local iip $PublicIPGlobal

:if ([:len $iip] = 0) do={
    :set iip "Unknown"
}

:set msg ($msg . $nm . "+" . $FlagResult . ":+" . $iip . "%0A")
            }
            :if ($r=false) do={ :set msg ($msg . $nm . "+%E2%9D%8C+DOWN%0A") }
        }
        /tool fetch url=($api . $token . "/sendMessage?chat_id=" . $chatid . "&text=" . $msg . "&reply_markup=" . $mainKbd) keep-result=no
    }

    :if ($cdata = "uptime") do={
        :local uptime [/system resource get uptime]
        :local msg ("%E2%8F%B1%EF%B8%8F+Uptime:+" . $uptime)
        /tool fetch url=($api . $token . "/sendMessage?chat_id=" . $chatid . "&text=" . $msg . "&reply_markup=" . $mainKbd) keep-result=no
    }
}

:if ([:find $data "update_id"] > 0) do={
    :local uidpos [:find $data "update_id"]
    :local commapos [:find $data "," $uidpos]
    :local uidstr [:pick $data ($uidpos+11) $commapos]
    :local newoffset ([:tonum $uidstr] + 1)
    :if ([:len $ifname] > 0) do={ /interface bridge set $ifname name=("tg-offset-" . $newoffset) }
    :if ([:len $ifname] = 0) do={ /interface bridge add name=("tg-offset-" . $newoffset) }
}