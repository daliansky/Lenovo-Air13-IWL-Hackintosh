DefinitionBlock ("", "SSDT", 2, "ACDT", "HPTE", 0)
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