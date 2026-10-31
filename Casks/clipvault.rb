cask "clipvault" do
  version "0.4.0"
  sha256 "15c25ab182ba67cd657c3bc4e66fbe7fc98835b7065318a72926aa69bde49564"

  url "https://github.com/Kamaliev/clipvault/releases/download/v#{version}/Clipvault-#{version}.zip"
  name "Clipvault"
  desc "Encrypted 24-hour clipboard history"
  homepage "https://github.com/Kamaliev/clipvault"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Clipvault.app"

  # Releases are signed ad hoc and not notarized.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Clipvault.app"]
    run "/usr/bin/osascript",
        args: ["-e", 'tell application "System Events" to make login item at end ' \
                     'with properties {path:"/Applications/Clipvault.app", hidden:false}'],
        must_succeed: false
  end

  uninstall_preflight_steps do
    run "/usr/bin/osascript",
        args: ["-e", 'tell application "System Events" to delete login item "Clipvault"'],
        must_succeed: false
  end

  uninstall quit: "com.kamaliev.clipvault"

  zap trash: [
    "~/Library/Application Support/Clipvault",
    "~/Library/Preferences/com.kamaliev.clipvault.plist",
  ]
end
