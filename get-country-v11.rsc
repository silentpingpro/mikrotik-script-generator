:global GeoIP_Iface
:global FlagCC
:global FlagResult
:set FlagResult ""
:local iip ""
:do { :set iip [/ip address get [/ip address find interface=$GeoIP_Iface] address] } on-error={}
:if ([:len $iip] > 0) do={
    :local iponly [:pick $iip 0 [:find $iip "/"]]
    :local err 0
    :do { /tool fetch url=("https://ip-api.com/json/" . $iponly . "?fields=countryCode") keep-result=yes dst-path=geoip-tmp.txt timeout=5s } on-error={ :set err 1 }
    :if ($err = 0) do={
        :local geodata [/file get geoip-tmp.txt contents]
        :local geos [:find $geodata "\"countryCode\":\""]
        :if ($geos > 0) do={
            :local geoe [:find $geodata "\"" ($geos+16)]
            :set FlagCC [:pick $geodata ($geos+16) $geoe]
            /system script run get-flag
        }
    }
}
