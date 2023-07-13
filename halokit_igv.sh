if command -v RNAfold > /dev/null 2>&1; then
    :
else 
    echo "The ViennaRNA package is required to use Halokit, to download it, follow these instructions: https://www.tbi.univie.ac.at/RNA/index.html#download"
fi

if command -v bedtools > /dev/null 2>&1; then
    :
else
    echo "Bedtools is required to use Halokit, to download it, follow these instructions: https://bedtools.readthedocs.io/en/latest/content/installation.html"
fi

if find ~ -name "igv.sh" > /dev/null 2>&1; then
    :
else 
    echo "IGV is required to use Halokit, to download it, follow these instructions: https://software.broadinstitute.org/software/igv/"
fi


echo '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢠⣶⣶⣶⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⠟⠛⢿⣶⡄⠀⢀⣀⣤⣤⣦⣤⡀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢠⣿⠋⠀⠀⠈⠙⠻⢿⣶⣶⣶⣶⣶⣶⣶⣿⠟⠀⠀⠀⠀⠹⣿⡿⠟⠋⠉⠁⠈⢻⣷⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣼⡧⠀⠀⠀⠀⠀⠀⠀⠉⠁⠀⠀⠀⠀⣾⡏⠀⠀⢠⣾⢶⣶⣽⣷⣄⡀⠀⠀⠀⠈⣿⡆⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⢸⣧⣾⠟⠉⠉⠙⢿⣿⠿⠿⠿⣿⣇⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢸⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣷⣄⣀⣠⣼⣿⠀⠀⠀⠀⣸⣿⣦⡀⠀⠈⣿⡄⠀⠀⠀
⠀⠀⠀⠀⠀⢠⣾⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠻⣷⣤⣤⣶⣿⣧⣿⠃⠀⣰⣿⠁⠀⠀⠀
⠀⠀⠀⠀⠀⣾⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠹⣿⣀⠀⠀⣀⣴⣿⣧⠀⠀⠀⠀
⠀⠀⠀⠀⢸⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⠿⠿⠛⠉⢸⣿⠀⠀⠀⠀
⢀⣠⣤⣤⣼⣿⣤⣄⠀⠀⠀⡶⠟⠻⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣶⣶⡄⠀⠀⠀⠀⢀⣀⣿⣄⣀⠀⠀
⠀⠉⠉⠉⢹⣿⣩⣿⠿⠿⣶⡄⠀⠀⠀⠀⠀⠀⠀⢀⣤⠶⣤⡀⠀⠀⠀⠀⠀⠿⡿⠃⠀⠀⠀⠘⠛⠛⣿⠋⠉⠙⠃
⠀⠀⠀⣤⣼⣿⣿⡇⠀⠀⠸⣿⠀⠀⠀⠀⠀⠀⠀⠘⠿⣤⡼⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣼⣿⣀⠀⠀⠀
⠀⠀⣾⡏⠀⠈⠙⢧⠀⠀⠀⢿⣧⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⠟⠙⠛⠓⠀
⠀⠀⠹⣷⡀⠀⠀⠀⠀⠀⠀⠈⠉⠙⠻⣷⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⣶⣿⣯⡀⠀⠀⠀⠀
⠀⠀⠀⠈⠻⣷⣄⠀⠀⠀⢀⣴⠿⠿⠗⠈⢻⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣾⠟⠋⠉⠛⠷⠄⠀⠀
⠀⠀⠀⠀⠀⢸⡏⠀⠀⠀⢿⣇⠀⢀⣠⡄⢘⣿⣶⣶⣤⣤⣤⣤⣀⣤⣤⣤⣤⣶⣶⡿⠿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠘⣿⡄⠀⠀⠈⠛⠛⠛⠋⠁⣼⡟⠈⠻⣿⣿⣿⣿⡿⠛⠛⢿⣿⣿⣿⣡⣾⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠙⢿⣦⣄⣀⣀⣀⣀⣴⣾⣿⡁⠀⠀⠀⡉⣉⠁⠀⠀⣠⣾⠟⠉⠉⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⠛⠛⠛⠉⠀⠹⣿⣶⣤⣤⣷⣿⣧⣴⣾⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠻⢦⣭⡽⣯⣡⡴⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀

Welcome to Halokit_IGV version pre-Alpha, the Halobacterium salinarum toolkit for genomic visualization
Input a sequence: '

#input sequence
read sequence 

#make temp directory and story the sequence on a fasta file
temp_dir=$(mktemp -d)
echo ">Sequence" > "$temp_dir/sequence.fa"
echo "$sequence" >> "$temp_dir/sequence.fa" 

#applying RNAfold to the input sequence fasta file and sending the output to a temp text file
sec_strc=$(RNAfold -p "$temp_dir/sequence.fa")
echo "$sec_strc" > "$temp_dir/secstrc.txt"
fold_result="$temp_dir/secstrc.txt"

#taking only the third line which corresponds to the simplest folding result and dropping out the MFE value (will use it later)
fold_result=$(head -n 3 "$fold_result" | tail -n 1)
length_seq=${#sequence}
fold_result="${fold_result:0:length_seq}"

#one lining the fasta entries for easier comparison 
awk '!/^>/ { printf "%s", $0; n = "\n" } /^>/ { print n $0; n = "" } END { printf "%s", n}' Hsalinarum.fa > Hsalonliner.fa

input_coord=$(grep -n -B 1 $sequence Hsalonliner.fa | awk -F ':' '{ print $2} ')
echo "$input_coord"

