cask "florin" do
  version "1.4.0"
  sha256 "380a8e11bd6d75f60fce41cf5b1dc2dcc88de9ba54806ddff5c6b1aaf0163d00"

  url "https://github.com/RashadAnsari/florin/releases/download/v#{version}/florin-macos.zip"
  name "Florin"
  desc "Bookkeeping for Dutch freelancers (ZZP)"
  homepage "https://github.com/RashadAnsari/florin"

  depends_on macos: ">= :monterey"

  app "Florin.app"

  # The database in Application Support holds the user's bookkeeping, so zap leaves it alone
  zap trash: "~/Library/Preferences/me.ansarihamedani.florin.plist"
end
