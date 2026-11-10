


while read -r ip hostname rest; do

    
    [[ -z "$ip" || "$ip" == \#* ]] && continue
    
    if [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then

        valid=true

        IFS='.' read -r -a octets <<< "$ip"

        for octet in "${octets[@]}"; do
            if (( octet < 0 || octet > 255 )); then
                valid=false
                break
            fi
        done

        if $valid; then
            echo "IP valid: $ip - $hostname"
        else
            echo "IP invalid: $ip - $hostname"
        fi

    else
        echo "IP invalid: $ip - $hostname"
    fi

done < /etc/hosts
