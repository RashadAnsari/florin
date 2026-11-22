cask "florin" do
  version "1.0.0"
  sha256 "15042ed994d93f0a6256424bb35d2d0852372726c263a070d97ce5c2df91d234"

  url "https://github.com/RashadAnsari/florin/releases/download/v#{version}/florin-macos.zip"
  name "Florin"
  desc "Bookkeeping for Dutch freelancers (ZZP)"
  homepage "https://github.com/RashadAnsari/florin"

  depends_on macos: ">= :monterey"

  app "Florin.app"

  # The database in Application Support holds the user's bookkeeping, so zap leaves it alone
  zap trash: "~/Library/Preferences/me.ansarihamedani.florin.plist"
end
