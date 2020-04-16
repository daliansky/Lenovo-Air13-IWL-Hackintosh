DefinitionBlock ("", "SSDT", 2, "ACDT", "DMAC", 0x00000000)
{
    External (_SB_.PCI0.LPCB, DeviceObj)
    Scope (_SB.PCI0.LPCB)
    {
        Device (DMAC)
        {
            Name (_HID, EisaId ("PNP0200"))
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
            Name (_CRS, ResourceTemplate ()
            {
                IO (Decode16,
                    0x0000,
                    0x0000,
                    0x01,
                    0x20,
                    )
                IO (Decode16,
                    0x0081,
                    0x0081,
                    0x01,
                    0x11,
                    )
                IO (Decode16,
                    0x0093,
                    0x0093,
                    0x01,
                    0x0D,
                    )
                IO (Decode16,
                    0x00C0,
                    0x00C0,
                    0x01,
                    0x20,
                    )
                DMA (Compatibility, NotBusMaster, Transfer8_16, )
                    {4}
            })
        }
    }
}