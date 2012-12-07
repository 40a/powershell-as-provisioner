	# -- 7ZIP
	if($7zip){
		writeMessage("Download, install and start 7zip.")
		install($7zip)
		writeMessage("Add the 7-Zip installation directory to the PATH environment variable.")
		[Environment]::SetEnvironmentVariable("PATH", "$env:PATH;$env:ProgramFiles\7-Zip", "Machine")
		$env:PATH="$env:PATH;$env:ProgramFiles\7-Zip"
		}