# macOS Quick Action: Generate App Icons

This Automator **Quick Action** adds a “Generate App Icons” option to your Finder
right-click menu. It converts a single transparent PNG into a full set of
cross-platform app icons for macOS, Windows, and Linux.

## Features

- Instantly accessible from Finder:  
  **Right-click → Quick Actions → Generate App Icons**
- Creates a new folder next to your PNG with:
  - macOS `.icns` (via `iconutil`)
  - Windows `.ico`
  - Linux `.png` set (various sizes)
- Transparent background and no drop shadows
- Automatically opens the output folder when done


## Requirements

- macOS with **Automator**
- [Homebrew](https://brew.sh)
- [ImageMagick](https://imagemagick.org) installed via Homebrew: `brew install imagemagick`

Verify the install path (usually /usr/local/bin/convert or /opt/homebrew/bin/convert): `which convert`


## Installation

Open Automator → New Document → choose Quick Action

### Configure:

1. Workflow receives current: image files
2. In: Finder
3. Add an action: Run AppleScript
4. Paste the contents of Generate App Icons.scpt

```
fastcsv_icons/
├── mac.iconset/
│   ├── icon_16x16.png
│   ├── icon_32x32@2x.png
│   └── ...
├── pngs/
│   ├── icon_16.png
│   ├── icon_512.png
│   └── ...
├── FastCSV.icns
└── FastCSV.ico
```

The folder opens automatically after generation.

## Customization

To adjust or troubleshoot:

Edit the ImageMagick path inside the AppleScript: `/usr/local/bin/convert`

Change icon sizes or output folder name as needed.

You can also add a timestamp or prefix in the script for versioning.

