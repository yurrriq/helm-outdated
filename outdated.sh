#! /usr/bin/env nix-shell

#! nix-shell --pure -i bash -p gawk kubernetes-helm

set -euo pipefail


subcharts=$(helm dep list | tail -n+2 | head -n-1 | sort -u)


current_version ()
{
    awk -v subchart="$1" 'subchart ~ $1 { print $2 }' <<<"$2"
}


find_latest ()
{
    helm search "$1" | awk -v subchart="$1" '$1 == subchart { print $2 }'
}


while IFS= read -r subchart
do
    current=$(current_version "$subchart" "$subcharts")
    latest=$(find_latest "$subchart")
    if [ "$current" == "$latest" ]
    then
        printf "%s is up to date.\\n" "$subchart"
    else
        printf "Consider upgrading %s: %s -> %s.\\n" \
               "$subchart" "$current" "$latest"
    fi
done < <(awk '{ sub("@","",$3); printf "%s/%s\n", $3, $1; } ' <<<"$subcharts")
