#!/bin/bash
read_file(){ 
    log_file='nginx-access.log'
    while read line
    do
        echo "$line"
    done < "$log_file"
}
