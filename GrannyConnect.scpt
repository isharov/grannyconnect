-- 1. Create a new generic password entry in Keychain Access called "AnyConnect_VPN" (the name in Keychain access must match that in line 39 below) with your password for the Cisco AnyConnect VPN server.
-- 2. Open this script in Script Editor (both this and the above are in the Applications->Utilities folder) and "Save as.." an Application (.app) with desired name.
-- 3. Open Security & Privacy System Preferences, go to Privacy, Accessibility.
-- 4. Enable the above .app so it can access Accessibility
-- 5. Copy and paste a nice icon on the generic Applescript icon (I used a copy of the default AnyConnect one)
-- 6. Add the new .app to /Users/[yourshortname]/Applications with a shortcut to your Dock
-- 7. Enjoy the fast connection with no need to enter password and increased security of not having a sensitive password stored as plain text
-- 8. Run script again to close connection

-- AnyConnect now refered to as targetApp
set targetApp to "Cisco AnyConnect Secure Mobility Client"

-- Determine if AnyConnect is currently running
tell application "System Events"
    set processExists to exists process targetApp
end tell

-- Reconnect if running; else start application
if processExists is true then
    tell application "System Events" to tell process targetApp
        -- Close warning banner
        set frontmost to true
        keystroke return

        -- Just disconnect if already connected
        try
            click button "Disconnect" of window 2
            delay 2
        end try
    end tell
else
    tell application targetApp
        activate
    end tell
end if

tell application "System Events"
    -- Wait for main window to open. Do nothing.
    repeat until (window 2 of process targetApp exists)
        delay 1
    end repeat

    -- You may need to uncomment below if your OpenConnect implementation requires a keystroke to accept the default VPN
    tell process targetApp
        keystroke return
    end tell

    -- Wait for auth window to open and then automatically enter password extracted from your Keychain
    repeat until (window 3 of process targetApp exists)
        delay 2
    end repeat
    delay 1
    tell process targetApp
        -- This is where the the password in the Keychain is accessed for use as input rather than being hardcoded as plain text in other versions of this script out in the wild
        set PSWD to do shell script "security find-generic-password -l AnyConnect_VPN -w"
        -- set PSWD to do shell script "security find-internet-password -a User -s server.example.com -w"
        keystroke PSWD as text
        delay 1
        keystroke return
    end tell

    -- Autoclick on "Accept" of AnyConnect Banner window. If you have no welcome banner that needs acceptance, comment out these lines to the first "end tell" below
    -- repeat until (window "Cisco AnyConnect - Banner" of process targetApp exists)
    --	delay 2
    -- end repeat
    -- tell process targetApp
    --     keystroke return
    -- end tell
end tell
