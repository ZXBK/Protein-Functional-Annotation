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

### Usage: 

```bash
docker pull el54vup/signalp:v1

docker run --rm -v $PWD:/in -w /in/ el54vup/signalp:v1 \
python3.8 Remove_signal_seq.py -i protein.faa -s signalp_output -o output.faa
```

### Note: 
- File should all be in the current directory
- Remove_signal_seq.py must be executable (sudo chmod -R 777 ./*)  
