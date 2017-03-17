#!/bin/bash

export PATH=$PATH:/usr/local/bro/bin

tab_delimited() {
	printf $1
	shift
	for arg in $@
	do
		printf "\t$arg"
	done
	printf "\n"
}

dump_brologs() {
	filename=$1
	output_filename=$1.rdf
	shift
	tab_delimited $@ > $output_filename
	cat $filename | bro-cut $@ >> $output_filename
}


# files
dump_brologs files.log tx_hosts  rx_hosts mime_type total_bytes



