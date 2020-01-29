DefinitionBlock ("", "SSDT", 2, "ACDT", "RMCF", 0)
{
    External (_SB.PCI0.LPCB.PS2K, DeviceObj)
    Scope (_SB.PCI0.LPCB.PS2K)
    {
        Name (RMCF,Package() 
        {
            "Keyboard", Package()
            {
                "Custom ADB Map", Package()
                {
                    Package(){},
                    "46=80",      // Disable Fn + K
                    "e045=80",    // Disable Fn + P
                    "e04e=80",    // Disable Fn + F4
                    "e003=80",    // Disable Fn + F7
                    "e04c=6b",    // Fn + F11 = F14
                    "e054=71",    // Fn + F12 = F15
                },
                "Custom PS2 Map", Package()
                {
                    Package(){},
                    "e037=e05e",    // PrtSc = System Power
                },
                "Make Application key into right windows", ">n", // Disable Make Application key into right windows
                "Swap command and option", ">n", // Disable Swap command and option
            },
        })
    }
}