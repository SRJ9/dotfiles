#-------------------------------------------------------------
# Administración de dispositivos:
#-------------------------------------------------------------
registerAssistanceSection "Gestión de dispositivos"
registerAssistance "pendrives-busy" "Comprobar qué pendrives están ocupados y qué impide el desmontaje.";
pendrives-busy(){
    for dev in /sys/block/sd*
    do
        device_info=`readlink $dev`
        if [[ $device_info == *"usb"* ]]
        then
            dev_name="${dev##*/}";
            busy=`lsof "/dev/${dev_name##*/}"*`;
            echo -n "/dev/$dev_name: ";
            if [[ "$busy" != "" ]]
            then
                echo "está ocupado.";
                echo "$busy" | tail -n +2;
            else
                echo "se puede desmontar.";
            fi
        fi
    done
}

registerAssistance "pendrives-list" "Listar los pendrives disponibles en el sistema.";
pendrives-list(){
    for dev in /sys/block/sd*
    do
        device_info=`readlink $dev`
        if [[ $device_info == *"usb"* ]]
        then
            dev_name="${dev##*/}"
            device_model=`cat $dev/device/model`
            size=`cat $dev/size`
            if [[ $size == "0" ]]
            then
                continue
            fi
            size=`numfmt --from-unit=K --to=iec-i --suffix=M $size`
            echo "/dev/$dev_name: $device_model ($size)";
            lsblk /dev/$dev_name | awk '{if(NR>2)print}'
        fi
    done
}

registerAssistance "lsmnt" "Listar todos los puntos de montaje.";
alias lsmnt='mount | column -t' # Listar dispositivos conectados