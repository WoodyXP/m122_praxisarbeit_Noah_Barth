while getopts f: optvar;
do
        # shellcheck disable=SC2220
        case $optvar in
                f) filename="${OPTARG}" ;;
        esac
done
. /logfunction.sh

grep -v '^#'|grep -v '^$'|while read username groupname name_firstname
do
        username=$username
        groupname=$groupname
        name_firstname=$name_firstname
        groupbackup="groupbackuplist"
        LOGLEVEL=I

        function user_exist () {
                if id $username >/dev/null 2<&1; then
                        echo "User already exists: $username"
                        home_directory_exist
                else
                        echo "New User Created: $username"
                        sudo useradd -g $groupname -m -k /etc/skel/$groupname -c "$name_firstname" -p "TestPWD" $username
                        log I User: $username was created, Added to Group: $groupname, Has a preset skeleton structure: /etc/skel/$groupname, Has Name: "$name_firstname"
                        is_in_backupfile
                fi
        }

        function home_directory_exist () {
                if [ ! -d "/home/$existing_username" ]; then
                        echo "Homedirectory for exists: $username"
                else
                        echo "Homedirectory doesn't exist, creating one for User: $username"
                        sudo mkdir -p /home/$username
                        log I Homedirectory 'for' existing User: $username was created
                fi
        }

        function add_folder_structure () {
                if [ -d "/etc/skel/$groupname" ]; then
                        echo "Group has skel structure: $groupname"
                        user_exist
                else
                        echo "Group doesn't have skel structure: $groupname"
                        echo "New User Created: $username"
                        sudo useradd -g $groupname -m -c "$name_firstname" -p "TestPWD" $username
                        log I User: $username was created, Added to Group: $groupname, Has Name: "$name_firstname"
                        is_in_backupfile
                fi
        }

        function usergroup_exist () {
                if [ $(getent group $groupname) ]; then
                        echo "Group exists: $groupname"
                        add_folder_structure
                else
                        echo "Group does not exist: $groupname"
                        echo "New Group: $groupname"
                        sudo groupadd $groupname
                        log I Group: $groupname was created
                        add_folder_structure
                fi
        }

        function is_in_backupfile () {
                if grep -i "$groupname" "$groupbackup"; then
                        echo "Backup for homedirectory of User: $username, from Group: $groupname"
                else
                        echo "No backup for homedirectory of User: $username, from Group: $groupname"
                        LOGLEVEL=W
                        log W No backup for homedirectory of User: $username, from Group: $groupname
                fi
        }
        usergroup_exist
        echo "-----------------------------------------------------------------------------------"
done < $filename
