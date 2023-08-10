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

#make temp directory and store the sequence on a fasta file
temp_dir=$(mktemp -d)
echo ">Sequence" > "$temp_dir/sequence.fa"
echo "$sequence" >> "$temp_dir/sequence.fa" 

#applying RNAfold to the input sequence fasta file and sending the output to a temp text file
sec_strc=$(RNAfold -p --salt=2.6 "$temp_dir/sequence.fa")
echo "$sec_strc" > "$temp_dir/secstrc.txt"
fold_result="$temp_dir/secstrc.txt"

#taking only the third line which corresponds to the simplest folding result and dropping out the MFE value (will use it later)
fold_result=$(head -n 3 "$fold_result" | tail -n 1)
length_seq=${#sequence}
fold_result="${fold_result:0:length_seq}"
echo $fold_result

#one lining the fasta entries for easier comparison 
awk '!/^>/ { printf "%s", $0; n = "\n" } /^>/ { print n $0; n = "" } END { printf "%s", n}' Hsalinarum.fa > "$temp_dir/Hsalonliner.fa"

#take the sequence and everything before to access the total position of the last nt and acessing the first nt after it
input_coord=$(grep -o -B 1 "^.*${sequence}" "$temp_dir/Hsalonliner.fa")
initial_position=$(expr ${#input_coord} - ${#sequence})
final_position=${#input_coord}

#function to convert matching parenthesis in the dot bracket notation into open-close index pairs
pairs() {
  local s=$* i open=() pairs=()
  for (( i=0; i <${#s}; ++i )); do
    if [[ ${s:i:1} = '(' ]]; then
      open=($i "${open[@]}")
    elif [[ ${s:i:1} = ')' ]]; then
      if (( ! ${#open[@]} )); then
        printf >&2 'Error: unmatched ")" at position %s\n' "$i"
        return 1
      fi
      pairs=("$((${open[0]} + $initial_position + 1)) $((i + $initial_position + 1))" "${pairs[@]}")
      open=("${open[@]:1}")
    fi
  done
  if (( ${#open[@]} )); then
    printf >&2 'Error: unmatched "(" at position %s\n' "${open[0]}"
    return 1
  fi
  printf '%s\n' "${pairs[@]}"
}

#sorting and tabbing the function result
pairs "$fold_result" | sed 's/ /\t/' > "$temp_dir/pairs_tab.txt"
sort -n -k1,1 "$temp_dir/pairs_tab.txt" > "pairs_sorted.txt"

#Arranging the Halo chromossomes
chroms=( "NC_002607.1" "NC_001869.1" "NC_002608.1" )

#Writing the bed file
fasta_first_line=$(head -n 1 "$temp_dir/Hsalonliner.fa")

for i in "${chroms[@]}"; do
  if echo "$fasta_first_line" | grep -q "$i"; then
    while IFS=$'\t' read -r start end; do
      echo -e "$i\t$start\t$end" >> "$temp_dir/chrom_added.txt"
    done < "pairs_sorted.txt"
    mv "$temp_dir/chrom_added.txt" "$temp_dir/pairs_sorted.txt"
  fi
done
        
header="track graphType=arc"
echo "$header" > "$temp_dir/header.txt"
cat "$temp_dir/pairs_sorted.txt" >> "$temp_dir/header.txt"
mv "$temp_dir/header.txt" "$pairs_sorted.bed"

#Writing the xml file to save a session
genome_path="~/Halokit_IGV/Hsalinarum.fa"

if echo "$fasta_first_line" | grep -q "NC_002607.1"; then
    locus="NC_002607.1:0-2014239"
if echo "$fasta_first_line" | grep -q "NC_001869.1"; then
    locus="NC_001869.1:0-191346"
if echo "$fasta_first_line" | grep -q "NC_002608.1"; then
    locus="NC_002608.1:0-365425"

path="~/Halokit_IGV/pairs_sorted.bed"

xml_content="<Session genome="$genome_path" locus="$locus" version="8">
    <Resources>
        <Resource path="$path" type="bed"/>
    
    




