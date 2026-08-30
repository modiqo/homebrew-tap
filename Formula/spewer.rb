# typed: false
# frozen_string_literal: true

class Spewer < Formula
  desc "Delegate bounded work to lower-cost agent harnesses"
  homepage "https://github.com/modiqo/spewer"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/modiqo/spewer/releases/download/v0.2.0/spewer-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "845b820dd19642ba50cb62874c090555b3029493fc8096df214fd42311236a36"
    else
      url "https://github.com/modiqo/spewer/releases/download/v0.2.0/spewer-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "ec5cfcba567f1d91f01a57259a74168593236613364cc4fee279965d4cd89c95"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/modiqo/spewer/releases/download/v0.2.0/spewer-v0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c28e4138e01628a465acbaf096135338a23f018f88091d2d3c4163edb01ffb62"
    else
      url "https://github.com/modiqo/spewer/releases/download/v0.2.0/spewer-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4d6f4530bb4f20209c82dc20c8ed4303ce0f96978fa9dc07c07c07a5ac1193bc"
    end
  end

  def install
    bin.install "spewer"
    bin.install_symlink bin/"spewer" => "spu"
  end

  def caveats
    <<~EOS
      Prepare the default Luna worker and detached service:
        spewer install
    EOS
  end

  test do
    assert_match "spewer #{version}", shell_output("#{bin}/spewer --version")
    assert_match "spewer #{version}", shell_output("#{bin}/spu --version")
  end
end
