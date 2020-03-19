if [ ! "$ZSHRC_CONFIG_USER" = 'MAC' ]
then return
fi

function vpnd() {
    vpn disconnect "$1"
}

function vpn() {
    case $1 in
        connect) : ;;
        disconnect) : ;;
        *) vpn connect "$1" ;;
    esac
    osascript -e "tell application \"System Events\"
          tell current location of network preferences
             set myConnection to the service \"${2:-"Unifi"}\"
             if myConnection is not null then
                 if current configuration of myConnection is not connected then
                     $1 myConnection
                 end if
             end if
         end tell
         return
      end tell"
}
