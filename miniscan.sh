#!/bin/bash
# Mini malware scanner

if [ $# -lt 1 ];then 
  echo "Usage ./miniscan.sh file1 [file2] [file3...]"
fi

for arg in $@;do
 if [ -e $arg ];then
   if [ -d $arg ];then
     echo "$arg is a directory"
   elif [ -f $arg ];then
     echo -e "\e[1;36m___${arg}___\e[0m"
     # FileType
     echo -e "\e[1;32mFileType\e[0m"
     echo " $(file $arg)"
     # Permissions
     echo -e "\e[1;32mPermissions\e[0m"
     echo " $(ls -lh $arg)"
     # Checksums
     echo -e "\e[1;32mChecksums\e[0m"
     echo " sha256: $(sha256sum $arg | cut -d " " -f 1)"
     echo " sha1: $(sha1sum $arg | cut -d " " -f 1)"
     echo " md5: $(md5sum $arg | cut -d " " -f 1)"
     # Suspicious strings
     _strings_=$(strings $arg)
     domains=$(grep -ioE "(http[s]*://(www\.)?[a-zA-Z0-9@:%._\+~#=]+{1,256}\.[a-zA-Z0-9()]{1,6}([-a-zA-Z0-9()@:%_\+.~#?&//=]*))" <<< "$_strings_")
     ipv4_urls=$(grep -ioE "(http[s]*://([0-9]{1,3}\.){3}[0-9]{1,3})" <<< "$_strings_")
     ipv4=$(grep -ioE "([0-9]{1,3}\.){3}[0-9]{1,3}" <<< "$_strings_")
     sus_strings=$(echo -e "$domains\n$ipv4_urls\n$ipv4")
     if [[ ! -z $sus_strings ]];then
        echo -e "\e[1;32mSuspicious strings\e[0m"
        echo $sus_strings | tr " " "\n" | while IFS= read -r line; do echo " $line"; done
     fi
    echo 
   fi
 else 
   echo "$arg don't exists"
 fi
done
