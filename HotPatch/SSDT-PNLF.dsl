DefinitionBlock ("", "SSDT", 2, "ACDT", "PNLF", 0x00000000)
{
    If (_OSI ("Darwin"))
    {
        Device (_SB.PNLF)
        {
            Name (_ADR, Zero)
            Name (_HID, EisaId ("APP0002"))
            Name (_CID, "backlight")
            Name (_UID, 0x13)
            Name (_STA, 0x0B)
        }
    }
}