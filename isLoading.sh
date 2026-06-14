#!/bin/bash

chars="/-\|"

for i in {1..20}; do
    printf "\rLoading... ${chars:i%4:1}"
    sleep 0.1
done

printf "\nDone!\n"