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
