GLEVEL=W        #Set default loglevel
log(){
        DATE=`date '+%Y.%m.%d %H:%M:%S'`
        LEVEL=$1
        shift
        case $LEVEL in
                D)
                        case $LOGLEVEL in
                                D)
                                        echo "$DATE:DEBUG:$*" >> usercreationlog.txt
                                        ;;
                        esac
                        ;;
                I)
                        case $LOGLEVEL in
                                D|I)
                                        echo "$DATE:INFO:$*"  >> usercreationlog.txt
                                        ;;
                        esac
                        ;;
                W)
                        case $LOGLEVEL in
                                D|I|W)
                                        echo "$DATE:WARNING:$*"  >> usercreationlog.txt
                                        ;;
                        esac
                        ;;
                E)
                        echo "$DATE:ERROR:$*"  >> usercreation.txt
                        ;;
                *)
                        echo "$DATE:UNKNOWN:$*"  >> usercreationlog.txt
                        ;;
        esac
}
