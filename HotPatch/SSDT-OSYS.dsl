// Rename  : Windows to Xindows
// Find    : 57696E64 6F7773
// Replace : 58696E64 6F7773
DefinitionBlock ("", "SSDT", 2, "ACDT", "OSYS", 0)
{
    External (OSYS, FieldUnitObj)
    Scope (_SB)
    {
        Device (PCI1)
        {
            Name (_ADR, Zero)
            Method (_INI, 0, NotSerialized)
            {
                OSYS = 0x07E2     //0x07D9: "Windows 2009" = win7
                                  //0x07DC: "Windows 2012" = win8
                                  //0x07DD: "Windows 2013" = win8.1
                                  //0x07DF: "Windows 2015" = Win10 Build 10536
                                  //0x07E0: "Windows 2016" = Win10 Build 15086
                                  //0x07E1: "Windows 2017" = Win10 Build 16299
                                  //0x07E2: "Windows 2018" = Win10 Build 17134
            }
            Method (_STA, 0, NotSerialized)
            {
                If (_OSI ("Linux"))
                {
                    Return (Zero)
                }
                Else
                {
                    Return (0x0F)
                }
            }
        }
    }
}