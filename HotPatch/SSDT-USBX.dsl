DefinitionBlock ("", "SSDT", 2, "ACDT", "USBX", 0x00000000)
{
    If (_OSI ("Darwin"))
    {
        Device (_SB.USBX)
        {
            Name (_ADR, Zero)
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