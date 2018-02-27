# Shell snippets useful for grepping/analyzing logs

#########################
########## AWK ##########
#########################

# Define awk delimiter
awk -F "pattern" '{print $0}'

# Define multiple awk delimeters (regex can be used)
# Note: Backslash must be double escaped
awk -F "pat1|pat2" '{print $0}'

# Print everything but 1st field
awk '{$1 = "" print $0}'

# Print only last column
awk '{print $NF}'

# Keep separator
awk -F ":" 'BEGIN {OFS = FS} {print $0}'

# Lines in both A, B
awk 'NR==FNR{a[$0];next}{if($0 in a)print $0}' a.txt b.txt

# Lines in B, but not in A
awk 'NR==FNR{a[$0];next}!($0 in a)' a.txt b.txt


##########################
########## FIND ##########
##########################

# Concat all files of a specific pattern history to be processed
# Note: zcat -f to force cat even on non zipped files
find <targetdir> -follow -name "pattern" | sort | xargs zcat -f

# Handle files with spaces or whitespace in name
find <targetdir> -follow -name "pattern" -print0 | sort -z | xargs -0 zgrep -h

#########################
########## SSH ##########
#########################

# Execute command on multiple servers with similar name
# Note: parameter argument '02g' forces padding to at least 2 digits
# Note: commands to be executed via ssh may need to be escaped or double escaped
{ for i in $(seq -f "%02g" 1 8); do echo "server-name$i.server-host.domain"; done } | xargs -I % ssh %  "hostname"

##########################
########## SORT ##########
##########################

# Sort stdin input, count by occurrence, sort high to low by occurrence
sort | uniq -c | sort -nr


