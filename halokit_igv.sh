#!/bin/bash

##################################################################################################
##################################################################################################
####                                 DEFINING FUNCTIONS                                       ####
##################################################################################################
##################################################################################################

help() {

  ### Will display the software docs. ###
  echo "Unavailable at the moment"
}

one_liner() {
  ### One lining user input fasta entries, will be used in an imperative option. ###

  local s=$*

  local onelined_fasta=$(awk '!/^>/ { printf "%s", $0; n = "\n" } /^>/ { print n $0; n = "" } END { printf "%s", n }' <<< "$s")

  echo "$onelined_fasta"
}

rna_fold() {
  ### Applies the RNAfold program to the input sequence. Receives the target sequence and the salt concentration. ###

  local sequence="$1" salt="$2"
  local temp_dir

  temp_dir=$(mktemp -d)

  echo ">Sequence" > "$temp_dir/sequence.fa"
  echo "$sequence" >> "$temp_dir/sequence.fa"

  if [ -z "$salt" ]; then
    sec_strc=$(RNAfold -p < "$temp_dir/sequence.fa")
  else
    sec_strc=$(RNAfold -p --salt="$salt" < "$temp_dir/sequence.fa")
  fi

  echo "$sec_strc" > "$temp_dir/secstrc.txt"
 
  local fold_result=$(head -n 3 "$temp_dir/secstrc.txt" | tail -n 1)

  local length_seq=${#sequence}
  fold_result="${fold_result:0:length_seq}"
  echo "$fold_result"

  rm -r "$temp_dir"
}

input_coord() {

  ### Take the sequence and everything before to access the total position of the last nt and acessing the first nt after it. ###

  local sequence="$1"
  local fasta_file="$2"

  input_coord=$(grep -o -B 1 "^.*${sequence}" "${fasta_file}")
  initial_position=$(expr ${#input_coord} - ${#sequence})
  final_position=${#input_coord}
}

pairs() {

  ### Function to convert matching parenthesis in the dot bracket notation into open-close index pairs. ###

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

to_bed() {

  ### Writes the result of the matched pairs into a bed file ###

  local fold_result="$1"

  pairs "$fold_result" | sed 's/ /\t/' > "$temp_dir/pairs_tab.txt"
  sort -n -k1,1 "$temp_dir/pairs_tab.txt" > "$temp_dir/pairs_sorted.txt"

  chroms=( "NC_002607.1" "NC_001869.1" "NC_002608.1" )

  fasta_first_line=$(head -n 1 "$temp_dir/Hsalonliner.fa")

  for i in "${chroms[@]}"; do
    if echo "$fasta_first_line" | grep -q "$i"; then
      while IFS=$'\t' read -r start end; do
        echo -e "$i\t$start\t$end" >> "$temp_dir/chrom_added.txt"
      done < "$temp_dir/pairs_sorted.txt"
      mv "$temp_dir/chrom_added.txt" "$temp_dir/pairs_sorted.txt"
    fi
  done
       
  header="track graphType=arc"
  echo "$header" > "$temp_dir/header.txt"
  cat "$temp_dir/pairs_sorted.txt" >> "$temp_dir/header.txt"
  mv "$temp_dir/header.txt" pairs_sorted.bed
}

start_igv() {

### Start igv with the files passed as parameters ###

local input="$1"

igv "$input"
}



##################################################################################################
##################################################################################################
####                                      MAIN PROGRAM                                        ####
##################################################################################################
##################################################################################################


echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
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
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠻⢦⣭⡽⣯⣡⡴⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"


template="Hsalinarum.fa"

while getopts "hf:r:" opt; do
  case $opt in
    h)
      help; exit;;
    r)
      sequence_salt="$OPTARG"
      IFS=' ' read -ra r_values <<< "$sequence_salt"
      sequence="${r_values[0]}"
      salt="${r_values[1]}"
      fold_result= rna_fold "$sequence" "$salt"
      f_file= one_liner "$template"
      input_coord "$sequence" "$template"
      to_bed "$fold_result"
      ;;
    /?)
      echo "invalid option"
      exit;;
  esac
done
