cwd=$(pwd)
cd $(dirname $0)
BINDIR=$(pwd)
cd $cwd
BASENAME=$(basename 0$)
TMPDIR=/tmp/$BAENAME.$$

. /logfunction.sh
source ../etc/backupCreate.env



#create file to write in users
touch users.txt;
#read all lines in groupnames.env and loop through it
cat $ETCDIR/groupnames.env|grep -v '^$'|grep -v '^#'|while read groupname 
do
#check if group exists
  if [ $(getent group $groupname) ]; then
    LOGLEVEL=I
    #grab all users of group and write them in variable (format is: user1,user2 etc)
    gid="$(getent group "$groupname" | cut -d: -f4)"
    #write variable in file
    echo "$gid" >> users.txt;
    LOG I fetched all users from group $groupname
  else
    LOGLEVEL=W
    echo "group $groupname does not exist."
    LOG W group $groupname does not exist
  fi
done

#format commas to line break
sed -i 's/,/\n/g' users.txt;
#remove duplicated users in file
awk '!seen[$0]++' users.txt > userList.txt;
#remove old list with duplicated entries
rm -r users.txt;

#To backup user's home directory
cat userList.txt|grep -v '^$'|grep -v '^#'|while read user
do 
  #check if user-home-directory exists
  if [ -d "/home/$user" ]; then
    #fetch user-home-directory
    awk -F: -v username=$user '$1==username {print $6}' /etc/passwd >> directoryList.txt
  else
    LOGLEVEL=W
    echo "no /home/$user directory";
    LOG W no /home/$user directory
  fi
done
rm -r userList.txt;
#genereate filename
filename=$NAME-$(date +%d-%m-%Y)
#create archive
tar -cvf $TARGET_DIRECTORY/$filename.tar -T directoryList.txt
rm -r directoryList.txt;
#remove archives older than x days. Only works in combination with crone-job
find $TARGET_DIRECTORY -type f -mtime +$DATE_TILL_DELETE -name '*.tar' -execdir rm -- '{}' \;
LOGLEVEL=I
LOG I Finished creating archive
