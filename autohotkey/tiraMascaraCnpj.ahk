#Persistent

OnClipboardChange("ClipChanged")
return

ClipChanged() {
    found := RegExMatch(Clipboard, "i)([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})")
    if(found = 1){
        Clipboard := StrReplace(Clipboard, ".")
        Clipboard := StrReplace(Clipboard, "-")
        Clipboard := StrReplace(Clipboard, "/")
    }
}

;([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})
;FoundPos := RegExMatch("abc123", "i)^ABC")  ; Returns 1 because a match was achieved via the case-insensitive option.