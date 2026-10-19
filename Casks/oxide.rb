cask "oxide" do
  version "0.1.0"
  sha256 "147b1b4a3e7c6c7e965a9507c11e7403958fb9f1a49a133e9729ac526b3a23aa"

  url "https://github.com/edkranz/oxide/releases/download/v#{version}/Oxide-macos-universal.zip"
  name "oxide"
  desc "Super light text editor built in Rust"
  homepage "https://github.com/edkranz/oxide"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Oxide.app"
  binary "#{appdir}/Oxide.app/Contents/SharedSupport/bin/ox"

  # The app is signed ad hoc, not notarised, so Gatekeeper would refuse to open it.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Oxide.app"]
  end

  zap trash: [
    "~/.config/oxide",
    "~/Library/Application Support/oxide",
    "~/Library/Caches/oxide",
  ]
end
