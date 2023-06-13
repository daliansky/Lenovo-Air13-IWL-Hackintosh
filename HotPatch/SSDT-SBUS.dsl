DefinitionBlock ("", "SSDT", 2, "ACDT", "SBUS", 0x00000000)
{
    External (_SB_.PCI0.SBUS, DeviceObj)
    
    If (_OSI ("Darwin"))
    {
        Device (_SB.PCI0.SBUS.BUS0)
        {
            Name (_CID, "smbus")
            Name (_ADR, Zero)
        }
    }
}