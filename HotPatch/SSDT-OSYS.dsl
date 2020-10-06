DefinitionBlock("", "SSDT", 2, "ACDT", "OSYS", 0x00000000)
{
    External (OSYS, FieldUnitObj)
    
    If (_OSI ("Darwin"))
    {
        Device (_SB.PCI1)
        {
            Name (_ADR, Zero)
            Method (_INI, 0, NotSerialized)
            {
                If (CondRefOf (\OSYS))
                {
                    OSYS = 0x07E2
                }
            }
        }
    }   
}