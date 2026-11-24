cask "florin" do
  version "1.3.0"
  sha256 "c13f9cc2d8fb42fe8b9429edc154cf1dbad2fb85cbcbe611cf0ac2df34117c9e"

  url "https://github.com/RashadAnsari/florin/releases/download/v#{version}/florin-macos.zip"
  name "Florin"
  desc "Bookkeeping for Dutch freelancers (ZZP)"
  homepage "https://github.com/RashadAnsari/florin"

  depends_on macos: ">= :monterey"

  app "Florin.app"

  # The database in Application Support holds the user's bookkeeping, so zap leaves it alone
  zap trash: "~/Library/Preferences/me.ansarihamedani.florin.plist"
end
