# Protein-Functional-Annotation
For Protein Sequences Annotation 
Version:
- TMHMM v2.0c
- signalP v4.1
- hmmscan v3.3
- ghostz v1.02

--- 
## Remove_signal_seq.py
[Docker hub](https://hub.docker.com/r/el54vup/signalp/tags)

In order to select potential AMP sequences, remove signal peptides from all sequences. 

Then use them as input to [AI4AXP](https://axp.iis.sinica.edu.tw) website. 

### Usage: 

```bash
docker pull el54vup/signalp:v1

docker run --rm -v $PWD:/in -w /in/ el54vup/signalp:v1 \
python3.8 Remove_signal_seq.py -i protein.faa -s signalp_output -o output.faa
```

### Note: 
- File should all be in the current directory
- Remove_signal_seq.py must be executable (sudo chmod -R 777 ./*)  
- output.faa can be predicted with [AI4AXP](https://axp.iis.sinica.edu.tw)

---
## DownloadSRA.sh
sra-tools 2.11.1 docker

input: SRR000001

output: fastq file


### Usage:
```bash
docker pull ncbi/sra-tools:2.11.1
chmod u+x DownloadSRA.sh
./DownloadSRA.sh -h
./DownloadSRA.sh -f SRR000001
```
### Note:

Be careful with memory usage!
One SRA file will create one container.

```bash
for i in $(cat file)
do
        ./DownloadSRA.sh ${i}    
done
```
