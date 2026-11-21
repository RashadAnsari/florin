cask "florin" do
  version "1.2.0-3"
  sha256 "cedcb4c34063ecdb19fca5e0547eec65c8d9d87bfe8aca934b6ed52742b87184"

  url "https://github.com/RashadAnsari/florin/releases/download/#{version}/florin-macos.zip"
  name "Florin"
  desc "Bookkeeping for Dutch freelancers (ZZP)"
  homepage "https://github.com/RashadAnsari/florin"

  depends_on macos: :catalina

  app "Florin.app"

  # The database in Application Support holds the user's bookkeeping, so zap leaves it alone
  zap trash: "~/Library/Preferences/me.ansarihamedani.florin.plist"
end
