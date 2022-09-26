#! python3.8
## kaochihhsin@gmail.com
## should be executed with docker images (el54vup/signalp)

from skbio import Protein,read
import pandas as pd
import string, argparse
from argparse import RawTextHelpFormatter
def read_signalp_output(path):
    df = pd.read_csv(path, sep = '\t',header = None, 
                     names = ['seq','source','feature','start','end','score','a','b','c'],
                     skiprows = 3,index_col = None,usecols = [0,3,4])
    return df
def read_faa(path):
    faa = read(path,format = 'fasta')
    list0 = []
    for i in faa:
        list0.append((i.metadata['id'],str(i)))
    dict0 = dict(list0)
    return dict0
def parse_sp(sp,faa,storefile):
    for i in range(len(sp)):
        sp_name = sp['seq'][i]
        sp_end = sp['end'][i]
        if len(faa[sp_name][sp_end:])<=50:
            outputfile = ">"+ sp_name+ '\n'+  faa[sp_name][sp_end:]+ '\n'
            storefile.write(outputfile)
        
def main():
    parser = argparse.ArgumentParser(description = 'Input: SignalP v4 output file, Protein fasta file \nOutput: Signal Protein fasta without signal part',
                                    formatter_class = RawTextHelpFormatter,
                                    epilog = 'Thank you for using!!')
    req = parser.add_argument_group('Required parameter')
    req.add_argument('-i', metavar = 'Input_Protein', required= True, action= 'store', help= 'Input Protein Fasta')
    req.add_argument('-s', metavar = 'Input_Signalp', required= True, action= 'store', help= 'Input SignalP Output')
    req.add_argument('-o', metavar = 'Output_file', required=True, action= 'store', help='Output Fasta File.')
    p = parser.parse_args()
    iP = read_faa(p.i)
    iS = read_signalp_output(p.s)
    storefile = open(p.o,'w')
    parse_sp(iS,iP,storefile)
    storefile.close()

if __name__ == '__main__':
    main()
