cask "florin" do
  version "1.5.0"
  sha256 "2e60bbf4ee186b4cdb442d8646dd46b838138d3a985522625e59da6368b08edf"

  url "https://github.com/RashadAnsari/florin/releases/download/v#{version}/florin-macos.zip"
  name "Florin"
  desc "Bookkeeping for Dutch freelancers (ZZP)"
  homepage "https://github.com/RashadAnsari/florin"

  depends_on macos: ">= :monterey"

  app "Florin.app"

  # The database in Application Support holds the user's bookkeeping, so zap leaves it alone
  zap trash: "~/Library/Preferences/me.ansarihamedani.florin.plist"
end
