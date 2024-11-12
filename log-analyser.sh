#!/bin/bash
top5_IP(){
    log_file='nginx-access.log'
    printf "Top 5 IP with the most requests \n"
    # On affiche la première colonne du fichier logs, on trie dans un premier temps les adresses IP puis on les compte puis on retrie en fonction du nombre de fois où elles apparaissent, puis on affiche le top 5
    # La boucle while va lire les deux colonnes count et ip puis les afficher dans l'ordre voulu (IP-COUNT)
    awk '{print $1}' "$log_file" | sort | uniq -c | sort -nr | head -n 5 | while read -r count ip; do
        printf "%s - %s requests\n" "$ip" "$count"
    done
}
top5_IP
