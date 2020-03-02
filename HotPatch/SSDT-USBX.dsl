DefinitionBlock ("", "SSDT", 2, "ACDT", "USBX", 0)
{
    Scope (_SB)
    {
        Device (USBX)
        {
            Name (_ADR, Zero)
            Method (_STA, 0, NotSerialized)  // _STA: Status
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
                    "kUSBSleepPowerSupply",
                    0x0A28,
                    "kUSBSleepPortCurrentLimit",
                    0x0960,
                    "kUSBWakePowerSupply",
                    0x0C80,
                    "kUSBWakePortCurrentLimit",
                    0x0960
                })
            }
        }
    }
}