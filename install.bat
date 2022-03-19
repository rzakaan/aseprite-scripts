:: copy scripts to aseprite folder
xcopy "src\*.lua" "%appdata%\Aseprite\scripts" \Y
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Scripts have been uploaded', 'Have a good drawings', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information);}"