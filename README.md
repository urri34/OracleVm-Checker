# ha-OracleVm-Checker
Conté els scripts de power shell que faig servir per operar el meu servidor d'OracleVM on viu l'HA

## ValidateVMUSB.ps1:
### Problema:
A vegades la VM pot entrar en suspensió i engegar-la a través de GUI pot ser "dificil", en canvi amb un scripts powershell es més assequible.

Les màquines virtuals OracleVM que tenen presentats dispositius USB directament, en cas de desconnexió momentanea de l'USB, el perden i no es torna a presentar automaticament. En el meu cas la màquina virtual d'HA té un USBWifi, un dongle Zigbee i un Zigbee2MQTT. A vegades es desconecta
### Solució: 
Valido que la VM estigui corrent i si no ho està l'engego.

Valido que tots els dispositus USB estan conectats i els conecto.
### Paràmetres:
>$Machine=@{VmUUID="f05c746c-a545-4329-8252-bc3b42907131";
>
>USBUUIDS = @("6f06b710-ee69-4e5d-917b-d0808827102c","93cedeaf-a6f8-49c2-ab9e-0192aa434ba2")}
Que provenen de:
>C:\Program Files\Oracle\VirtualBox\VBoxManage.exe
Name:                        HomeAssistant_v01
Encryption:     disabled
Groups:                      /
Guest OS:                    Linux 2.6 / 3.x / 4.x / 5.x (64-bit)
UUID:                        f05c746c-a545-4329-8252-bc3b42907131
Config file:                 C:\HomeAssistant\VM\HomeAssistant_v01\HomeAssistant_v01.vbox
Snapshot folder:             C:\HomeAssistant\VM\HomeAssistant_v01\Snapshots
Log folder:                  C:\HomeAssistant\VM\HomeAssistant_v01\Logs
Hardware UUID:               f05c746c-a545-4329-8252-bc3b42907131
Memory size:                 2048MB
Page Fusion:                 disabled
VRAM size:                   16MB
CPU exec cap:                40%
HPET:                        disabled
CPUProfile:                  host
Chipset:                     piix3
Firmware:                    EFI
Number of CPUs:              2
