DefinitionBlock ("", "SSDT", 2, "ACDT", "SBUS", 0x00000000)
{
    External (_SB_.PCI0.SBUS, DeviceObj)
    Scope (_SB.PCI0.SBUS)
    {
        Device (BUS0)
        {
            Name (_ADR, Zero)
            Name (_CID, "smbus")
            Method (_STA, 0, NotSerialized)
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
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