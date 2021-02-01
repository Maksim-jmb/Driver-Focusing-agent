#include "FTL.Common.iss"

objectdef ftlSession
{
    variable ftlSettings Settings

    method Initialize()
    {
        LGUI2:LoadPackageFile[xFTL.Session.lgui2Package.json]
        ; FocusClick eat
    }

    method Shutdown()
    {
        LGUI2:UnloadPackageFile[xFTL.Session.lgui2Package.json]
    }

    method FTLfocus(uint toSlot)
    {
        if ${toSlot.Equal[${FtlSlot}]}
        {
            ; echo "FTLfocus return toSlot ${toSlot} ${FtlSlot}"
            return
        }
        else
        {
            uplink focus jmb${toSlot}
            ; echo "FTLfocus toSlot ${toSlot} ${FtlSlot}"
        }
    }

    method FTLswaplayout(uint mslot)
    {
        if ${mslot.Equal[${FtlSlot}]}
        {
            ; echo "FTLswaplayout return toSlot ${toSlot} ${FtlSlot}"
            return
        }
        if ${mslot.NotEqual[${FtlSlot}]}
        {
            relay ${Session} BRRSession:Disable
            relay ${Session} BWLSession:ApplyWindowLayout
            relay ${Session} "This:FTLfocus[${FtlSlot}]"
            ; echo "FTLswaplayout ${FtlSlot}"
        }
    }
}

variable(global) ftlSession FTLSession

function main()
{
    while 1
    {
        waitframe
    }
}
