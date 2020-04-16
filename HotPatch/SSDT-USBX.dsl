DefinitionBlock ("", "SSDT", 2, "ACDT", "USBX", 0x00000000)
{
    Scope (_SB)
    {
        Device (USBX)
        {
            Name (_ADR, Zero)
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
            Method (_DSM, 4, NotSerialized)
            {
                If ((Arg2 == Zero))
                {
                    Return (Buffer (One)
                    {
                         0x03
                    })
                }
                Return (Package ()
                {
                    "kUSBSleepPortCurrentLimit",
                    0x0960,
                    "kUSBWakePortCurrentLimit",
                    0x0960
                })
            }
        }
    }
}