#!/bin/bash
# It creates a BACKUP-[DATE].tar.gz file in $HOME directory
# It's compatible with cron

datetime=$(date +%d-%m-%yT%H-%M-%S)
name="BACKUP-${datetime}"
route="$HOME/${name}.tar.gz"                        
# change with yours
files="$HOME/Codigo $HOME/Documentos $HOME/Laboratorio $HOME/.vimrc $HOME/.bashrc $HOME/.config/nvim $HOME/bookmarks.html $HOME/.tmux.conf $HOME/.config/sxhkd $HOME/.config/bspwm $HOME/.config/alacritty"

# Create backup, change with your files/dirs routes
tar czfv "${route}" $files
if [ $? -ne 0 ];then
 echo "Error creating the backup"
 exit 1
fi

# Remove the others
backups=$(find "$HOME" -maxdepth 1 -name "BACKUP*" -type f)

if [ -z $backups ];then
  echo "There are not backup files."
  exit 1
fi

newest=$(echo "$backups" | xargs ls -t | head -n 1)

for backup in $backups; do
  if [ "$backup" != "$newest" ];then
    echo "Deleting $backup"
    rm "$backup"
  fi
done

echo "Done."
exit 0
