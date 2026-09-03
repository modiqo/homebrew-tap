# typed: false
# frozen_string_literal: true

# A tiny cron with a memory: schedule any command, keep every result,
# recall on a timescale.
class Tulving < Formula
  desc "Tiny cron with a memory: schedule commands, keep results, recall"
  homepage "https://github.com/modiqo/tulving"
  version "0.1.5"
  license any_of: ["MIT", "Apache-2.0"]

  BASE = "https://github.com/modiqo/tulving/releases/download/v#{version}"

  on_macos do
    if Hardware::CPU.arm?
      url "#{BASE}/tulving-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "762fbab284e3254470feb29f3c0cb9a496636712f5a5aa37b5d1a70354c77001"
    else
      url "#{BASE}/tulving-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "7b19f6af65090c9fcaff694c811583000d913d7441e7a6c9c412040d63de47e4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "#{BASE}/tulving-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "33cc2dab1e185bc7d66a26cb3440146c4f5774662420d5778606e13332d3af10"
    else
      url "#{BASE}/tulving-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a51a2bfc4ec3cb9237c56e846375651324757a37dfbaffd71af94761992f6e55"
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
