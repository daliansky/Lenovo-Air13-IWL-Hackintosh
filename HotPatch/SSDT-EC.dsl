DefinitionBlock ("", "SSDT", 2, "ACDT", "EC", 0x00000000)
{
    External (_SB_.PCI0.LPCB, DeviceObj)
    
    If (_OSI ("Darwin"))
    {
        Device (_SB.PCI0.LPCB.EC)
        {
            Name (_HID, "ACID0001")
        }
    }
}