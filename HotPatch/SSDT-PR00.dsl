DefinitionBlock ("", "SSDT", 2, "ACDT", "PR00", 0x00000000)
{
    External (_SB_.PR00, ProcessorObj)
    
    If (_OSI ("Darwin"))
    {
        Scope (_SB.PR00)
        {
            Method (_DSM, 4, NotSerialized)
            {
                If ((Arg2 == Zero))
                {
                    Return (Buffer (One)
                    {
                        0x03
                    })
                }
                Return (Package (0x02)
                {
                    "plugin-type", 
                    One
                })
            }
        }
    }
}