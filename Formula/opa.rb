class Opa < Formula
  desc "Open source, general-purpose policy engine"
  homepage "https://www.openpolicyagent.org"
  url "https://github.com/open-policy-agent/opa/archive/v0.15.1.tar.gz"
  sha256 "b51fd9ba0d99d084c01ceace50cd31b900a12f61dd9d6c6fb5ce7f026a8556b2"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "5b040f862b1f8febca1031dd600d675ca7c9998915cccde83e7e7a6ac3b6dbb5" => :catalina
    sha256 "35ae3d2d0b2dff9bfecf056f3a254bc7dee5bf4a69ac10e7ea7db27a5385a7c2" => :mojave
    sha256 "4dc691f3a22472f4dee0ae9b480c4d7a0fa8096b3381838b6134f33ccab8a457" => :high_sierra
    sha256 "46f634e71b3f487193a3f202e565924e306b46162f2b8a7968c218a40ad1b9c1" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/"opa", "-trimpath", "-ldflags",
                 "-X github.com/open-policy-agent/opa/version.Version=#{version}"
    prefix.install_metafiles
  end

  test do
    output = shell_output("#{bin}/opa eval -f pretty '[x, 2] = [1, y]' 2>&1")
    assert_equal "+---+---+\n| x | y |\n+---+---+\n| 1 | 2 |\n+---+---+\n", output
    assert_match "Version: #{version}", shell_output("#{bin}/opa version 2>&1")
  end
end
