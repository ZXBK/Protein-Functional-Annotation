#!/bin/bash
##Goal: annotation with pfam,nr,singalP,tmhmm
##Kao Chih Hsin, Oct/2021
##chmod u+x *.sh 
###pfamdb:~/pfam34/Pfam-A.hmm
###nohup sh script.sh -f faa -d ~/pfam34/Pfam-A.hmm -t 30 &

usage()
{
        echo "Usage: `basename $0` -h help -f file.pep -d pfamDB [-t threads]"
        echo "          -f: protein sequence (output from Transdecoder)"
        echo "          -d: path to pfam database (had been hmmpress)(~/pfam34/Pfam-A.hmm)"
        echo "          -t: number of threads (default=20) "
        exit 0
}

### get options
while getopts 'f:d:t:h' OPT; do
        case $OPT in
                f)
                        file="$OPTARG";;
                d)
                        db="$OPTARG";;
                t)
                        threads="$OPTARG";;
                h)
                        usage;;
                ?)
                        usage;;
        esac
done



### check required variants
if [ -z $file ] || [ -z $db ] ; then
        usage
fi

### set default values while optional variants were not set
if [ -z $threads ]; then
        threads=20
fi

echo Input: $file
echo Threads: $threads
echo


echo =====   TMHMM v2.0c  =====

nohup ~/tmhmm-2.0c/bin/tmhmm --short < $file > tmhmm.out & 
pids="$!"
echo processing TMHMM  PID: $pids


echo =====   signalP v4.1  =====
nohup ~/tools/signalp-4.1/signalp -f short -n signalP.gff $file > signalP.log & 

pids="$!"
echo processing signalP  PID: $pids


echo =====   hmmscan v3.3  =====

nohup hmmscan --cpu $threads --domtblout pfam.out -E 0.001 ~/pfam34/Pfam-A.hmm $file > pfam.log &
pids="$!"
echo processing hmmscan  PID: $pids


echo =====   ghostz v1.02  =====

nohup /ghostz102/ghostz aln -i $file \
-d /nr2022/nr2022_gz -o ghostz.out -v 1 -b 1 -a $threads > ghostz_run.log &
pids="$!"
echo processing ghostz PID: $pids
echo
echo $(date '+%d %B %T') ...... Processing
wait $pids

echo $(date '+%d %B %T') ...... Finish! :D
