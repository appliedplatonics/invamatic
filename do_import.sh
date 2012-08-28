#!/bin/bash
#
# This sets up the initial dev environment with good data
#
# Before running this, you'll need to create TSV (tab-separated value)
# files for your line items from the various suppliers. This process
# needs a great deal more documentation.
#
# XXX TODO Document the import flow better.
#


rake db:migrate
./script/runner ./script/import_inventory.rb "mouser" ./imported_data/mouser/mouser_import.tsv 
./script/runner ./script/import_inventory.rb "jameco" ./imported_data/jameco/jameco_import.tsv 
./script/runner ./script/import_inventory.rb "tayda" ./imported_data/tayda/import_tayda.tsv 
./script/runner ./script/import_inventory.rb "pcbcart" ./imported_data/pcbcart/import_pcbcart.tsv 
