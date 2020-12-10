DefinitionBlock ("", "SSDT", 2, "ACDT", "RMCF", 0x00000000)
{
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)
    
    If (_OSI ("Darwin"))
    {
        Name (_SB.PCI0.LPCB.PS2K.RMCF, Package (0x02)
        {
            "Keyboard",
            Package ()
            {
                "Custom ADB Map",
                Package ()
                {
                    "46=80",    // Disable Fn + K
                    "e045=80",    // Disable Fn + P
                    "e04e=80"    // Disable Fn + F4
                },
                "Custom PS2 Map",
                Package ()
                {
                    "e037=e05e"    // PrtSc = System Power
                }
            }
        })
    }
}