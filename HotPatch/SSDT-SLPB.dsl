DefinitionBlock("", "SSDT", 2, "ACDT", "SLPB", 0x00000000)
{
    If (_OSI ("Darwin"))
    {
        Device (_SB.SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E"))
            Name (_STA, 0x0B)
        }
    }
}