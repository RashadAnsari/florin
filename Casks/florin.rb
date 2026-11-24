cask "florin" do
  version "1.1.0"
  sha256 "6ec67e617f0a1e24265c4cd6ded42d0415c6486db472caf6289a75d34f50a19a"

  url "https://github.com/RashadAnsari/florin/releases/download/v#{version}/florin-macos.zip"
  name "Florin"
  desc "Bookkeeping for Dutch freelancers (ZZP)"
  homepage "https://github.com/RashadAnsari/florin"

  depends_on macos: ">= :monterey"

  app "Florin.app"

  # The database in Application Support holds the user's bookkeeping, so zap leaves it alone
  zap trash: "~/Library/Preferences/me.ansarihamedani.florin.plist"
end
