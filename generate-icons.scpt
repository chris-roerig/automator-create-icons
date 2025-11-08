on run {input, parameters}
	try
		repeat with anItem in input
			set inputFile to POSIX path of anItem
			set fileName to do shell script "basename " & quoted form of inputFile & " .png"
			set parentDir to do shell script "dirname " & quoted form of inputFile
			set outputDir to parentDir & "/" & fileName & "_icons"

			do shell script "mkdir -p " & quoted form of outputDir & "/mac.iconset"
			do shell script "mkdir -p " & quoted form of outputDir & "/pngs"

			-- create cropped temp file
			set croppedFile to outputDir & "/" & fileName & "_cropped.png"
			do shell script "/usr/local/bin/convert " & quoted form of inputFile & " -crop 770x760+128+132 +repage " & quoted form of croppedFile

			-- macOS iconset sizes
			set macSizes to {"16", "32", "64", "128", "256", "512", "1024"}
			repeat with s in macSizes
				do shell script "/usr/local/bin/convert " & quoted form of croppedFile & " -resize " & s & "x" & s & " " & quoted form of (outputDir & "/mac.iconset/icon_" & s & "x" & s & ".png")
				do shell script "/usr/local/bin/convert " & quoted form of croppedFile & " -resize " & (s as integer) * 2 & "x" & (s as integer) * 2 & " " & quoted form of (outputDir & "/mac.iconset/icon_" & s & "x" & s & "@2x.png")
			end repeat

			-- Linux PNG sizes
			set linuxSizes to {"16", "24", "32", "48", "64", "128", "256", "512"}
			repeat with s in linuxSizes
				do shell script "/usr/local/bin/convert " & quoted form of croppedFile & " -resize " & s & "x" & s & " " & quoted form of (outputDir & "/pngs/icon_" & s & ".png")
			end repeat

			-- Generate Windows .ico
			do shell script "/usr/local/bin/convert " & quoted form of croppedFile & " -define icon:auto-resize=16,24,32,48,64,128,256 " & quoted form of (outputDir & "/" & fileName & ".ico")

			-- Generate macOS .icns if iconutil exists
			try
				do shell script "iconutil -c icns " & quoted form of (outputDir & "/mac.iconset") & " -o " & quoted form of (outputDir & "/" & fileName & ".icns")
			on error
				display notification "iconutil not available — skipped .icns generation." with title "Generate App Icons"
			end try

			-- Optional: open the output folder in Finder
			do shell script "open " & quoted form of outputDir

			display notification "✅ Icon export complete for “" & fileName & "”" with title "Generate App Icons"
		end repeat
	on error errMsg
		display dialog "Error: " & errMsg buttons {"OK"} default button 1 with icon caution
	end try

	return input
end run
