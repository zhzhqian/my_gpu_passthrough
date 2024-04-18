#!/bin/bash
qemu-system-x86_64 \
    -enable-kvm \
    -nographic \
    -L .                                  \
    --bios bios.bin                       \
    -m 24G                                \
    -cpu host,kvm=off                     \
    -smp $(nproc)                         \
    -drive file=/dev/nvme1n1,format=raw,media=disk \
    -device vfio-pci,host=01:00.0,x-vga=on,multifunction=on,romfile=rtx4060ti.rom \
    -device usb-ehci,id=ehci -device usb-host,bus=ehci.0,vendorid=0x2717,productid=0x5031 \
    -device vfio-pci,host=01:00.1 \
    -device qemu-xhci,id=xhci \
    -device usb-host,bus=xhci.0,vendorid=0x2717,productid=0x5031 \
    -device usb-host,bus=xhci.0,vendorid=0x2d99,productid=0xa019 \
    -device usb-host,bus=xhci.0,vendorid=0x05ac,productid=0x024f \
    -net nic -net user,hostfwd=tcp::50000-:22,hostfwd=tcp::50001-:5900,hostname=gentoo_qemu
    #-netdev user,id=net0,hostfwd=tcp::50000-:22 \
    #-device e1000e,netdev=net0
    #-net user,hostfwd=tcp::50000-:22,hostfwd=tcp::50001-:5900,hostname=gentoo_qemu
    #-nographic \
    #-device pcie-root-port,id=pcie.1,bus=pcie.0,addr=1c.0,slot=1,chassis=1,multifunction=on \
    #-device vfio-pci,host=01:00.0,bus=pcie.1,addr=00.0,x-vga=on,multifunction=on,romfile=NVIDIA.RTX4060Ti.8192.230306.rom \
    #-device vfio-pci,host=01:00.1,bus=pcie.1,addr=00.1
    #-device usb-ehci,id=ehci -device usb-host,bus=ehci.0,vendorid=0x2717,productid=0x5031
    #-device usb-ehci,id=ehci -device usb-host,bus=ehci.0,hostbus=1,hostaddr=12
    #-device usb-ehci,id=ehci -device usb-host,bus=ehci.1,vendorid=0x2717,productid=0x5031
    #-device usb-host,hostdevice=/dev/bus/usb/001/012 \
    #-device usb-host,hostdevice=/dev/bus/usb/001/014 \
    #-device usb-host,hostdevice=/dev/bus/usb/001/015 \
