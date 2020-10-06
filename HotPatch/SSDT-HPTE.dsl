DefinitionBlock ("", "SSDT", 2, "ACDT", "HPTE", 0x00000000)
{
    External (HPTE, FieldUnitObj)

    If (_OSI ("Darwin"))
    {
        HPTE = Zero
    }
}