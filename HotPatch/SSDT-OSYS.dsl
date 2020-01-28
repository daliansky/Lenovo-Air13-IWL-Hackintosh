DefinitionBlock("", "SSDT", 2, "ACDT", "OSYS", 0)
{
    External (OSYS, FieldUnitObj)
    Scope (_SB)
    {
        Device (PCI1)
        {
            Name (_ADR, Zero)
            Method (_INI, 0, NotSerialized)
            {
                If (CondRefOf (\OSYS))
                {
                    OSYS = 0x07E2
                }
            }
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
        }
    }   
}