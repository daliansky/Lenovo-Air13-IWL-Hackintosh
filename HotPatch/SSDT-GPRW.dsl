// Rename  : GPRW, 2 to XPRW, 2
// Find:     47505257 02
// Replace:  58505257 02
DefinitionBlock ("", "SSDT", 2, "ACDT", "GPRW", 0x00000000)
{
    External (XPRW, MethodObj)
    Scope (\)
    {
        Method (GPRW, 2, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If ((0x6D == Arg0))
                {
                    Return (Package (0x02)
                    {
                        0x6D, 
                        Zero
                    })
                }
            }
            Return (XPRW (Arg0, Arg1))
        }
    }
}