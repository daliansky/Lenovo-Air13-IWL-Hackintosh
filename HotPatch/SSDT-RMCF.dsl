DefinitionBlock ("", "SSDT", 2, "ACDT", "RMCF", 0x00000000)
{
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)
    
    If (_OSI ("Darwin"))
    {
        Name (_SB.PCI0.LPCB.PS2K.RMCF, Package (0x02)
        {
            "Keyboard", 
            Package (0x02)
            {
                "Custom ADB Map", 
                Package (0x03)
                {
                    Package (0x00){}, 
                    "46=80", 
                    "e045=80"
                }
            }
        })
    }
}