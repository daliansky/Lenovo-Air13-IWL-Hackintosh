DefinitionBlock ("", "SSDT", 2, "ACDT", "SBUS", 0x00000000)
{
    External (_SB_.PCI0.SBUS, DeviceObj)
    
    If (_OSI ("Darwin"))
    {
        Device (_SB.PCI0.SBUS.BUS0)
        {
            Name (_CID, "smbus")
            Name (_ADR, Zero)
            Device (DVL0)
            {
                Name (_ADR, 0x57)
                Name (_CID, "diagsvault")
                Method (_DSM, 4, NotSerialized)
                {
                    If (!Arg2)
                    {
                        Return (Buffer (One)
                        {
                             0x57
                        })
                    }
                    Return (Package (0x02)
                    {
                        "address", 
                        0x57
                    })
                }
            }
        }
    }
}