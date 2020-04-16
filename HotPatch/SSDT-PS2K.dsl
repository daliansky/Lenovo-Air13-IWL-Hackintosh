DefinitionBlock ("", "SSDT", 2, "ACDT", "PS2K", 0x00000000)
{
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)
    If (_OSI ("Darwin"))
    {
        Scope (_SB.PCI0.LPCB.PS2K)
        {
            Name (RMCF, Package (0x02)
            {
                "Keyboard",
                Package (0x08)
                {
                    "Custom ADB Map",
                    Package (0x05)
                    {
                        "46=80",    // Disable Fn + K
                        "e045=80",    // Disable Fn + P
                        "e04e=80",    // Disable Fn + F4
                        "e04c=6b",    // Fn + F11 = F14
                        "e054=71"    // Fn + F12 = F15
                    },
                    "Custom PS2 Map",
                    Package (0x01)
                    {
                        "e037=e05e"    // PrtSc = System Power
                    },
                    "Make Application key into right windows",
                    ">n",    // Disable Make Application key into right windows
                    "Swap command and option",
                    ">n"    // Disable Swap command and option
                }
            })
        }
    }
}