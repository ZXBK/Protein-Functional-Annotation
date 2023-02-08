#!/bin/bash
#Kao Chih Hsin
#Sep3,2021
##docker pull ncbi/sra-tools:2.11.1
##chmod u+x *.sh 

usage()
{
        echo "    Usage: Process_NCBI_file.sh [-f accession] "
        echo "          -f: accession, ex:SRR00000000"

        exit 0
}

### get options
while getopts 'f:O:h' OPT; do
        case $OPT in
                f)
                        file="$OPTARG";;

                h)
                        usage;;
                ?)
                        usage;;
        esac
done


echo Start download NCBI accession: $file ...

nohup docker run --rm -v $PWD:/in -w /in ncbi/sra-tools:2.11.1 prefetch $file &
pids="$pids $!"
echo $pids
wait $pids

nohup docker run --rm -v $PWD:/in -w /in ncbi/sra-tools:2.11.1 fasterq-dump -S $file &
pids="$pids $!"
echo $pids
wait $pids

echo DONE!
