#!/bin/bash

# usage: ovautil.sh <command> [<args>]
# commands:
#  - extract: extract the OVA file
#  - rehash: rehash the OVF and VMDK files
#  - package: package the OVF and VMDK files into an OVA file
#  - help: show this help message

# extract: <image.ova> <output-directory>
# rehash: <image.ovf> [<image.vmdk> ...]
# package: <output-directory> <output.ova>

function main () {
	case "${1}" in
		extract)
			shift
			if [[ $# -ne 2 ]]; then
				echo "Usage: extract <image.ova> <output-directory>"
				exit 1
			fi
			if [[ ! -f ${1} ]]; then
				echo "Error: File ${1} does not exist."
				exit 1
			fi
			mkdir -p ${2}
			tar -xzvf ${1} -C ${2}
		;;
		package)
			shift
			if [[ $# -ne 2 ]]; then
				echo "Usage: package <output-directory> <output.ova>"
				exit 1
			fi
			if [[ ! -d ${1} ]]; then
				echo "Error: Directory ${1} does not exist."
				exit 1
			fi
			tar -czvf ${2} -C ${1} .
		;;
		rehash)
			shift
			if [[ $# -lt 1 ]]; then
				echo "Usage: rehash <image.ovf> [<image.vmdk> ...]"
				exit 1
			fi
			if [[ ! -f ${1} ]]; then
				echo "Error: File ${1} does not exist."
				exit 1
			fi
			sha256sum ${@} | awk '{ print "SHA256(" $2 ")= " $1 }'
		;;
		*)
			echo "Usage: $0 <command> [<args>]"
			echo "Commands:"
			echo "  extract: extract the OVA file"
			echo "  rehash: rehash the OVF and VMDK files"
			echo "  package: package the OVF and VMDK files into an OVA file"
			echo "  help: show this help message"
			echo ""
			exit 1
		;;
	esac
	
}

main "$@"
