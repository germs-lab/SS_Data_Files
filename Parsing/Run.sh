#!/bin/bash
the_path=$(dirname "${0}")
length=$(($#-1))
Input=${@:1:$length}
Output=${@:$#}

if [ ! -d $Output ]; then
mkdir -p $Output/blast_Files/Uncategorized
fi

for file in $Input; do
	python $the_path/Working_Files/Parse.py $file $Output/blast_Files $the_path
done

wc -l $Output/blast_Files/*.fa | cut -f1 -d '.' | sed 's|Output/blast_Files/||g' | sed '/total/d' > $Output/Counts.list


#Rscript Working_Files/plot_output.r $Output/Counts.list $Output/Graph.png --save

