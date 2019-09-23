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
                    "46=80",      // Disable Fn+K
                    "e045=80",    // Disable Fn+P
                    "e05b=3a",    // Left Win = Left Alt
                    "38=37",      // Left Alt = Left Win
                    "e05c=3d",    // Right Win = Right Alt
                    "e038=36",    // Right Alt = Right Win               
                    "e05e=7f",    // System Power
                }, 
                "Custom PS2 Map", Package()
                {
                    Package(){},
                    "e037=e05e",    // PrtSc = System Power
                },
            },
        })      
    }
}