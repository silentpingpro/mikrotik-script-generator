:global GeoIPIface
:global FlagCC
:global FlagResult
:global PublicIPGlobal

:if ([:len $FlagCC] = 0) do={ :set FlagCC "" }
:if ([:len $FlagResult] = 0) do={ :set FlagResult "" }
:if ([:len $PublicIPGlobal] = 0) do={ :set PublicIPGlobal "" }

:set FlagCC ""

# گرفتن IP محلی تونل
:local localip ""

:do {

    :set localip [/ip address get [/ip address find interface=$GeoIPIface] address]

} on-error={

    :log warning ("GeoIP: interface " . $GeoIPIface . " has no address")
    :return
}


:if ([:len $localip] = 0) do={
    :return
}


:local srcip [:pick $localip 0 [:find $localip "/"]]


# گرفتن Public IP از همان تونل

:local PublicIP ""

:do {

    :local r [/tool fetch \
        url="https://api.ipify.org" \
        src-address=$srcip \
        output=user \
        as-value]

    :set PublicIP ($r->"data")

} on-error={

    :log warning ("GeoIP: cannot reach ipify via " . $GeoIPIface)
    :return
}


:if ([:len $PublicIP] < 7) do={
    :return
}


# ذخیره برای bale-listener

:set PublicIPGlobal $PublicIP


# دریافت کشور

:do {

    :local r [/tool fetch \
        url=("http://208.95.112.1/json/" . $PublicIP . "?fields=countryCode") \
        output=user \
        as-value]


    :local json ($r->"data")

    :local p1 [:find $json "\"countryCode\":\""]


    :if ([:typeof $p1] != "nil") do={

        :local p2 [:find $json "\"" ($p1 + 15)]

        :set FlagCC [:pick $json ($p1 + 15) $p2]

        /system script run get-flag

    }

} on-error={

    :log warning "GeoIP: Country lookup failed"

}