# typed: false
# frozen_string_literal: true

# A tiny cron with a memory: schedule any command, keep every result,
# recall on a timescale.
class Tulving < Formula
  desc "Tiny cron with a memory: schedule commands, keep results, recall"
  homepage "https://github.com/modiqo/tulving"
  version "0.1.1"
  license any_of: ["MIT", "Apache-2.0"]

  BASE = "https://github.com/modiqo/tulving/releases/download/v#{version}"

  on_macos do
    if Hardware::CPU.arm?
      url "#{BASE}/tulving-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "e1a2284e0c4ac1f568f68fcf1b070f79ef7ad74fb5d89530ac8b0e9797e671b8"
    else
      url "#{BASE}/tulving-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "bebfe4ced9b66463396c64473242b4fe0ef75cf8f40cb2ccb881d7b5058a34ad"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "#{BASE}/tulving-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "09827f22555afb078258a52d7b9d281ef9800161a9e4042c69d4c5ff9a288ea8"
    else
      url "#{BASE}/tulving-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f4e36d4fc0e3f9a2875ba687bead1b2ab6314cef99f390e848c5b3c82c6d0bf4"
    end
  end

  def install
    bin.install "tulving"
  end

  def caveats
    <<~EOS
      Register the per-user timer (no daemon):
        tulving init
      Then keep something running:
        tulving every morning --why "..." -- <command>
    EOS
  end

  test do
    assert_match "tulving", shell_output("#{bin}/tulving --version")
  end
end
