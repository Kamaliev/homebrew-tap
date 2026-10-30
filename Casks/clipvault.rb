cask "clipvault" do
  version "0.1.1"
  sha256 "48a51c9c03fcab631b23e9ce33e2bffa5b1ca066cf6453bbb87ae6b8091ff388"

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
  end

  uninstall quit: "com.kamaliev.clipvault"

  zap trash: [
    "~/Library/Application Support/Clipvault",
    "~/Library/Preferences/com.kamaliev.clipvault.plist",
  ]
end
