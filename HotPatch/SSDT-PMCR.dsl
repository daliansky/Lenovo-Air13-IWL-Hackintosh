DefinitionBlock ("", "SSDT", 2, "ACDT", "PMCR", 0)
{
    External (_SB_.PCI0, DeviceObj)
    Scope (_SB.PCI0)
    {
        Device (PMCR)
        {
            Name (_HID, EisaId ("APP9876"))
            Method (_STA, 0, NotSerialized)
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }
            Name (_CRS, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite,
                    0xFE000000,
                    0x00010000,
                    )
            })
        }
    }
}