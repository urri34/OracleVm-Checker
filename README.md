# OracleVm-Checker
Contains the PowerShell scripts I use to operate my OracleVM server where HA resides.
## ValidateVMUSB.ps1:
### Issues:
- Sometimes the VM may go into suspension, and starting it through the GUI can be "difficult," whereas with a PowerShell script, it is more accessible.
- OracleVM virtual machines that have USB devices directly attached may lose connection temporarily when the USB is disconnected and do not automatically reconnect. In my case, the HA virtual machine has a USB Wifi, a Zigbee dongle, and a Zigbee2MQTT. Sometimes it gets disconnected.
- Especially if the USB Wifi drops, a reload of the HA configuration needs to be done.

### Solution:
- Validate that the VM is running, and if it's not, start it.
- Validate that all USB devices are connected and connect them.
- Perform a reload of the network part of the HA VM (injecting commands through the VM console).

## Parameters:
> $Machine=@{VmUUID="`f05c746c-a545-4329-8252-bc3b42907131`";
> 
> USBUUIDS = @("`6f06b710-ee69-4e5d-917b-d0808827102c`","`93cedeaf-a6f8-49c2-ab9e-0192aa434ba2`")}

Obtained from:
```sh
C:\Program Files\Oracle\VirtualBox\VBoxManage.exe list --long vms
C:\Program Files\Oracle\VirtualBox\VBoxManage.exe list usbhost
```

VmUUID part:
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

USBUUIDS part:
>UUID:               `6f06b710-ee69-4e5d-917b-d0808827102c`
>
> VendorId:           0x138a (138A)
>
> ProductId:          0x00ab (00AB)
>
> Revision:           1.100 (01100)
>
> Port:               8
>
> USB version/speed:  2/Full
>
> Manufacturer:       Wifi USB Stick Realteck
>
> Address:            {53d29ef7-377c-4d14-864b-eb3a85769359}\0000
>
> Current State:      Busy

(...)
>UUID:               `93cedeaf-a6f8-49c2-ab9e-0192aa434ba2`
>
> VendorId:           0x0bda (0BDA)
>
> ProductId:          0x8153 (8153)
>
> Revision:           49.0 (4900)
>
> Port:               2
>
> USB version/speed:  3/Super
>
> Manufacturer:       Realtek Semiconductor Corp.
>
> Product:            RTL8153 Zigbee Adapter
>
> Address:            {4d36e972-e325-11ce-bfc1-08002be10318}\0020
>
> Current State:      Busy

## Extra bonus
### Hide shutdown/reboot button
My windows10 machine where I run my OracleVM with my VM inside is connected to the TV so the kids can play Netflix and wotch only stuff thru the browsers. But My wife sometimes forget that the HAServer is running in background and just shutdown the server after whatching a film. Avoid it!
>
>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\Start\HideShutDown
>
