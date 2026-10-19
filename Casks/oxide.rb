cask "oxide" do
  version "0.2.0"
  sha256 "fdfa40c22158f400a97850743dbc6d3302d1504dee36eeebb5ef2dd2d9aa20cf"

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
