#!/bin/bash
# This sets up the initial dev environment with good data

rake db:migrate
./script/runner ./script/import_inventory.rb "mouser" ./imported_data/mouser/mouser_import.tsv 
./script/runner ./script/import_inventory.rb "jameco" ./jameco/jameco_import.tsv 
./script/runner ./script/import_inventory.rb "tayda" ./tayda/import_tayda.tsv 
./script/runner ./script/import_inventory.rb "tayda" ./imported_data/tayda/import_tayda.tsv 
./script/runner ./script/import_inventory.rb "pcbcart" ./imported_data/pcbcart/import_pcbcart.tsv 
