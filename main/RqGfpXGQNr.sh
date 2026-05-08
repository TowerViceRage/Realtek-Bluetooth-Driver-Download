#!/bin/bash
if [ $# -ne 1 ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi
filename="$1"
if [ ! -f "$filename" ]; then
  echo "File not found!"
  exit 1
fi
line_count=$(wc -l < "$filename")
word_count=$(wc -w < "$filename")
char_count=$(wc -c < "$filename")
longest_line=$(awk '{ if(length > max_length) { max_length = length; longest = $0 } } END { print longest }' "$filename")
shortest_line=$(awk '{ if(length < min_length || min_length == 0) { min_length = length; shortest = $0 } } END { print shortest }' "$filename")
echo "File: $filename"
echo "Lines: $line_count"
echo "Words: $word_count"
echo "Characters: $char_count"
echo "Longest line: $longest_line"
echo "Shortest line: $shortest_line"
if [ $line_count -gt 0 ]; then
  average_length=$(echo "scale=2; $char_count / $line_count" | bc)
echo "Average line length: $average_length"
fi
if [ $word_count -gt 0 ]; then
  average_word_length=$(echo "scale=2; $char_count / $word_count" | bc)
echo "Average word length: $average_word_length"
fi
awk '{ print NR, $0 }' "$filename" > temp_file.txt
mv temp_file.txt "$filename"
echo "Line numbers added to file."
