DefinitionBlock ("", "SSDT", 2, "ACDT", "HPTE", 0x00000000)
{
    External (HPTE, FieldUnitObj)
    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            HPTE = Zero
        }
    }
}