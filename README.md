# grannyconnect
Connect to Cisco VPN in one click

1. Create a new generic password entry in Keychain Access called "AnyConnect_VPN" with your password for the Cisco AnyConnect VPN server.
2. Open this script in Script Editor (both this and the above are in the Applications->Utilities folder) and "Save as.." an Application (.app) with desired name.
3. Open Security & Privacy System Preferences, go to Privacy, Accessibility.
4. Enable the above .app so it can access Accessibility
5. Copy and paste a nice icon on the generic Applescript icon (I used a copy of the default AnyConnect one)
6. Add the new .app to /Users/[yourshortname]/Applications with a shortcut to your Dock
7. Enjoy the fast connection with no need to enter password and increased security of not having a sensitive password stored as plain text
8. Run script again to close connection
