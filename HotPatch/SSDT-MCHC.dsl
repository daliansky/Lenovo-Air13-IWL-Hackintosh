DefinitionBlock ("", "SSDT", 2, "ACDT", "MCHC", 0x00000000)
{
    External (_SB_.PCI0, DeviceObj)
    
    If (_OSI ("Darwin"))
    {
        Device (_SB.PCI0.MCHC)
        {
            Name (_ADR, Zero)
        }
    }
}