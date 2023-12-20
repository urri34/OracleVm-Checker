# HA-OracleVm-Checker
Conté els scripts de power shell que faig servir per operar el meu servidor d'OracleVM on viu el HA
## ValidateVMUSB.ps1:
### Problemes:
- A vegades la VM pot entrar en suspensió i engegar-la a través de GUI pot ser "dificil", en canvi amb un scripts powershell es més assequible.
- Les màquines virtuals OracleVM que tenen presentats dispositius USB directament, en cas de desconnexió momentanea de l'USB, el perden i no es torna a presentar automaticament. En el meu cas la màquina virtual d'HA té un USBWifi, un dongle Zigbee i un Zigbee2MQTT. A vegades es desconecta
- Sobretot si cau l'USBWifi s'ha de fer un reload de la configuració del HA

### Solució:
- Valido que la VM estigui corrent i si no ho està l'engego.
- Valido que tots els dispositus USB estan conectats i els conecto.
- Faig un reload de la part de xarxa de la VM HA (injectant comandes a través de la consola de la VM)

## Paràmetres:
> $Machine=@{VmUUID="`f05c746c-a545-4329-8252-bc3b42907131`";
USBUUIDS = @("`6f06b710-ee69-4e5d-917b-d0808827102c`","`93cedeaf-a6f8-49c2-ab9e-0192aa434ba2`")}

Obtinguts de:
```sh
C:\Program Files\Oracle\VirtualBox\VBoxManage.exe list --long vms
C:\Program Files\Oracle\VirtualBox\VBoxManage.exe list usbhost
```

La part de VmUUID:
>C:\Program Files\Oracle\VirtualBox\VBoxManage.exe list --long vms
>
>Name:                        TestHA
>
>Encryption:     disabled
>
>Groups:                      /
>
>Guest OS:                    Linux (64-bit)
>
>UUID:                        `f05c746c-a545-4329-8252-bc3b42907131`
>
>Config file:                 C:\TestHA.vbox
>
>Snapshot folder:             C:\Snapshots
>
>Log folder:                  C:\Logs
>
>Hardware UUID:               `f05c746c-a545-4329-8252-bc3b42907131`

La part de USBUUIDS:
>UUID:               `6f06b710-ee69-4e5d-917b-d0808827102c`
VendorId:           0x138a (138A)
ProductId:          0x00ab (00AB)
Revision:           1.100 (01100)
Port:               8
USB version/speed:  2/Full
Manufacturer:       Wifi USB Stick Realteck
Address:            {53d29ef7-377c-4d14-864b-eb3a85769359}\0000
Current State:      Busy

(...)
>UUID:               `93cedeaf-a6f8-49c2-ab9e-0192aa434ba2`
VendorId:           0x0bda (0BDA)
ProductId:          0x8153 (8153)
Revision:           49.0 (4900)
Port:               2
USB version/speed:  3/Super
Manufacturer:       Realtek Semiconductor Corp.
Product:            RTL8153 Gigabit Ethernet Adapter
Address:            {4d36e972-e325-11ce-bfc1-08002be10318}\0020
Current State:      Busy
