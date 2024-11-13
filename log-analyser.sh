#!/bin/bash
counts=5
log_file='nginx-access.log'

top5_IP(){
    printf "Top 5 IP with the most requests \n"
    # On affiche la première colonne du fichier logs, on trie dans un premier temps les adresses IP puis on les compte puis on retrie en fonction du nombre de fois où elles apparaissent, puis on affiche le top 5
    # La boucle while va lire les deux colonnes count et ip puis les afficher dans l'ordre voulu (IP-COUNT)
    awk '{print $1}' "$log_file" | sort | uniq -c | sort -nr | head -n $counts | while read -r count ip; do
        printf "%s - %s requests\n" "$ip" "$count"
    done
}

top5_path(){
    echo "Top 5 requested paths"
    awk '{print $7}' "$log_file" | sort | uniq -c | sort -nr | head -n $counts | while read -r count paths; do
        printf "%s - %s requests\n" "$paths" "$count"
    done
}

top5_http_code(){
    echo "Top 5 HTTP code"
    grep -oE ' [1-9][0-9]{2} ' "$log_file" | sort | uniq -c | sort -nr | head -n $counts | while read -r count code; do
        printf "%s - %s requests\n" "$code" "$count"
    done
}

top5_user_agent(){
    echo "Top 5 User-Agent"
    # On affiche de la 12ème à la dernière colonne pour avoir le nom complet du User-Agent
    awk '{for(i=12;i<=NF;i++)printf $i " "; print " "}' "$log_file" | sort | uniq -c | sort -nr | head -n $counts | while read -r count code; do
        printf "%s - %s requests\n" "$code" "$count"
    done
}

top5_IP
echo ""
top5_path
echo ""
top5_http_code
echo ""
top5_user_agent
