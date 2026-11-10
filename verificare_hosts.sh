
verifica_ip() {

    hostname="$1"
    ip="$2"
    dns_server="$3"

   
    if [[ ! "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        echo "IP invalid: $ip"
        return 1
    fi

    IFS='.' read -r -a octets <<< "$ip"

    for octet in "${octets[@]}"; do
        if (( octet > 255 )); then
            echo "IP invalid: $ip"
            return 1
        fi
    done

    
    rezultat=$(dig @"$dns_server" +short "$hostname" A)

    if [[ "$rezultat" == "$ip" ]]; then
        echo "Asociere corecta: $hostname -> $ip"
    else
        echo "Asociere incorecta: $hostname -> $ip"
    fi
}


DNS_SERVER="8.8.8.8"


while read -r ip hostname rest; do

    [[ -z "$ip" || "$ip" == \#* ]] && continue

    verifica_ip "$hostname" "$ip" "$DNS_SERVER"

done < /etc/hosts

