#!/bin/bash
# Bash script to calculates the MAX, MIN, MEDIAN and MEAN of the word frequencies in the
# file the  http://www.gutenberg.org/files/58785/58785-0.txt

if [ $# -ne 1 ]
   then
       echo "Please provide a txt file url"
       echo "usage ./calculate_basic_stats.sh  url"
       #exit with error
       exit 1
fi   

echo  "############### Statistics for file  ############### "

# Q1(.5 point) write  positional parameter after echo to print its value. It is the file url used by curl command.

echo $1


# sort based on multiple columns
#Q2(2= 1+1 for right sorting of each columns). Write last sort command options so that first column(frequencies) is
#sorted via numerical values and
#second column is sorted by reverse alphabetical order

sorted_words=`curl -s $1|tr [A-Z] [a-z]|grep -oE "\w+"|sort|uniq -c|sort -k 1n -k 2r `

total_uniq_words=`echo "$sorted_words" | wc -l`
echo "Total number of words = $total_uniq_words"


#Q3(1=.5+.5 points ) Complete the code in the following echo statements to calculate the  Min and Max frequency with respective word
#Hint:  Use sorted_words variable, head, tail and command susbtitution

min_word=`echo "$sorted_words" | head -1`
max_word=`echo "$sorted_words" | tail -1`
echo "Min frequency and word = $min_word"
echo "Max frequency and word = $max_word"



#Median calculation

#Q4(2=1(taking care of even number of frequencies)+1 points(right value of median)). Using sorted_words,
#write code for median frequency value calculation. Print the value of the median with an echo statement, stating
# it is a median value.
#Code must check even or odd  number of unique words. For even case median is the mean of middle two values,
#for the odd case, it is middle value in sorted items.
flag=$((${total_uniq_words}%2))
if [ $flag -eq 0 ]
    then 
        median=$((${total_uniq_words}/2))
        median2=$((median+1))
        med_freq1=`echo "$sorted_words"|sed -n "$median p" | awk '{print $1}'`
        med_freq2=`echo "$sorted_words"|sed -n "$median2 p" | awk '{print $1}'`
        echo "Median frequency value is $(( (med_freq1+med_freq2)/2 ))"
    else
        median=$((${total_uniq_words}+1))
        median=$((${median}/2))
        med_freq=`echo "$sorted_words"|sed -n "$median p" | awk '{print $1}'`
        echo "Median frequency value is $med_freq"
fi



# Mean value calculation
#Q5(1 point) Using for loop, write code to update count variable: total number of unique words
#Q6(1 point) Using for loop, write code to update total_freq variable : sum of frequencies
total_freq=0
count=0
size=`echo "$sorted_words" | awk '{print $1}'`
for i in $size
do 
    ((count++))
    total_freq=$((total_freq + i))
done



#Q7(1 point) Write code to calculate mean frequency value based on total_freq and count
mean=$((total_freq / count))



echo "Sum of frequencies = $total_freq"
echo "Total unique words = $count"
echo "Mean frequency using integer arithmetics = $mean"

#Q8(1 point) Using bc -l command, calculate mean value.
# Write your code after = 
echo "Mean frequency using floating point arithemetics =  `echo "$total_freq / $count" |bc -l`"



# Q9 (1 point) Complete lazy_commit bash function(look for how to write bash functions) to add, commit and push to the remote master.
# In the command prompt, this function is used as
#
# lazygit file_1 file_2 ... file_n commit_message
#
# This bash function must take files name and commit message as positional parameters
# and perform followling git function
#
# git add file_1 file_2 .. file_n
# git commit -m commit_message
# git push origin master

#
# Side: In the Linux if we put this function in .bashrc hidden file in
# the user home directory(type cd ~ to go to the home directory) and source .bashrc after adding this function,
# lazy_commit should be available in the command prompt.
# One can type lazy_commit file1 file2 ... filen  commit_message
# and file will be added , commited and pushed to remote master using one lazy_commit command.
function lazy_commit() {
commit_message=${!#}
for((i=1;i<$#;i++))
do
    file=${!i}
    #echo $file
    git add $file
done

git commit -m "`echo "$commit_message"`"
git push origin master
}

### function Test
#echo "---function commit start---"
## useage: lazy_commit "filename1" "filename2" ... "commit message"
#lazy_commit calculate_basic_stats.sh "script submitted"
#echo "---function commit end-----"

###output
#---function commit start---
#[master 83c2cf1] script submitted
#1 file changed, 127 insertions(+)
#create mode 100755 calculate_basic_stats.sh
#Username for 'https://github.com': huiduAtDU
#Password for 'https://huiduAtDU@github.com':
#Counting objects: 3, done.
#Delta compression using up to 4 threads.
#Compressing objects: 100% (3/3), done.
#Writing objects: 100% (3/3), 2.02 KiB | 2.02 MiB/s, done.
#Total 3 (delta 0), reused 0 (delta 0)
#To https://github.com/huiduAtDU/data_science_tools.git
#ea6123b..83c2cf1  master -> master
#---function commit end-----

