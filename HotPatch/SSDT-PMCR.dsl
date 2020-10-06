DefinitionBlock ("", "SSDT", 2, "ACDT", "PMCR", 0x00000000)
{
    External (_SB_.PCI0.LPCB, DeviceObj)
    
    If (_OSI ("Darwin"))
    {
        Device (_SB.PCI0.LPCB.PMCR)
        {
            Name (_HID, EisaId ("APP9876"))
            Name (_STA, 0x0B)
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