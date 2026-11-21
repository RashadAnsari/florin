cask "florin" do
  version "1.1.0-2"
  sha256 "2ff0eac7b705cc611201759280a3128e6a4f64e1086be1eca9a67a97e9b62f38"

  url "https://github.com/RashadAnsari/florin/releases/download/#{version}/florin-macos.zip"
  name "Florin"
  desc "Bookkeeping for Dutch freelancers (ZZP)"
  homepage "https://github.com/RashadAnsari/florin"

  depends_on macos: :catalina

  app "Florin.app"

  # The database in Application Support holds the user's bookkeeping, so zap leaves it alone
  zap trash: "~/Library/Preferences/me.ansarihamedani.florin.plist"
end
