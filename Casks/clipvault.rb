cask "clipvault" do
  version "0.1.0"
  sha256 :no_check

  url "https://github.com/Kamaliev/clipvault/releases/download/v#{version}/Clipvault-#{version}.zip"
  name "Clipvault"
  desc "Encrypted 24-hour clipboard history"
  homepage "https://github.com/Kamaliev/clipvault"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "Clipvault.app"

  # Releases are signed ad hoc and not notarized.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Clipvault.app"]
  end

  uninstall quit: "com.kamaliev.clipvault"

  zap trash: [
    "~/Library/Application Support/Clipvault",
    "~/Library/Preferences/com.kamaliev.clipvault.plist",
  ]
end
