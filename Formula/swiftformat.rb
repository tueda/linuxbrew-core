class Swiftformat < Formula
  desc "Formatting tool for reformatting Swift code"
  homepage "https://github.com/nicklockwood/SwiftFormat"
  url "https://github.com/nicklockwood/SwiftFormat/archive/0.43.1.tar.gz"
  sha256 "acb31a02dabfa8cf0baebb737442aa8890fb487f094a3be9f8446d3faefcb663"
  head "https://github.com/nicklockwood/SwiftFormat.git", :shallow => false

  bottle do
    cellar :any_skip_relocation
    sha256 "9ecc1900890ca6f93a7a6ec2a65771f884c9d741c2bbbff60869734dd4d4acf4" => :catalina
    sha256 "98a91b56fc113e49ca633e3083f06fc62c2da8578e41704c58afa3d7443ec7cc" => :mojave
    sha256 "6e9934157d8a3d8aa4861df83e6b3d30a6efed29a0e261ddb7344a05439332ee" => :high_sierra
  end

  depends_on :xcode => ["10.1", :build] if OS.mac?
  depends_on :macos

  def install
    xcodebuild "-project",
        "SwiftFormat.xcodeproj",
        "-scheme", "SwiftFormat (Command Line Tool)",
        "CODE_SIGN_IDENTITY=",
        "SYMROOT=build", "OBJROOT=build"
    bin.install "build/Release/swiftformat"
  end

  test do
    (testpath/"potato.swift").write <<~EOS
      struct Potato {
        let baked: Bool
      }
    EOS
    system "#{bin}/swiftformat", "#{testpath}/potato.swift"
  end
end
