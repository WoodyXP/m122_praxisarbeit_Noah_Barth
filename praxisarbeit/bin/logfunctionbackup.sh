GLEVEL=W        #Set default loglevel
log(){
        DATE=`date '+%Y.%m.%d %H:%M:%S'`
        LEVEL=$1
        shift
        case $LEVEL in
                D)
                        case $LOGLEVEL in
                                D)
                                        echo "$DATE:DEBUG:$*" >> backuplog.txt
                                        ;;
                        esac
                        ;;
                I)
                        case $LOGLEVEL in
                                D|I)
                                        echo "$DATE:INFO:$*"  >> backuplog.txt
                                        ;;
                        esac
                        ;;
                W)
                        case $LOGLEVEL in
                                D|I|W)
                                        echo "$DATE:WARNING:$*"  >> backuplog.txt
                                        ;;
                        esac
                        ;;
                E)
                        echo "$DATE:ERROR:$*"  >> backuplog.txt
                        ;;
                *)
                        echo "$DATE:UNKNOWN:$*"  >> backuplog.txt
                        ;;
        esac
}
