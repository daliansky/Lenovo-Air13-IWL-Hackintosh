DefinitionBlock ("", "SSDT", 2, "ACDT", "XSPI", 0x00000000)
{
    External (_SB_.PCI0, DeviceObj)
    
    If (_OSI ("Darwin"))
    {
        Device (_SB.PCI0.XSPI)
        {
            Name (_ADR, 0x001F0005)
        }
    }
}