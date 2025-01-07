#!/bin/bash
# It creates a BACKUP-[DATE].tar.gz file

datetime=$(date +%d-%m-%yT%H-%M-%S)
name="BACKUP-${datetime}"
route="/home/$USER/${name}.tar.gz"                        # Change with the route that you want

# Create backup, change with your files/dirs routes
backupfiles=(
"/home/$USER/Codigo"
"/home/$USER/Documentos"
"/home/$USER/Laboratorio"
"/home/$USER/.vimrc"
"/home/$USER/.bashrc"
"/home/$USER/.config/nvim"
"/home/$USER/bookmarks.html"
)
tar czfv "${route}" "${backupfiles[@]}"
if [ $? -ne 0 ];then
 echo "Error creating the backup"
 exit 1
fi

# Remove the oldest
salvas=$(find /home/$USER/ -type f -name 'BACKUP*');    
IFS=$'\n' read -rd '' -a sarray <<< "$salvas"         
if (( ${#sarray[@]} > 1 )); then        
 size=${#sarray[@]}  
 oldest=''
 for ((i=0; i<size; i++)); do
  if [ -z "$oldest" ] || [ "${sarray[i]}" -ot "$oldest" ]; then
   oldest="${sarray[i]}"
  fi
 done
 rm $oldest   
 if [ $? -ne 0 ];then
  echo "Error removing ${oldest}"
  exit 1
 fi
fi
