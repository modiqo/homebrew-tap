# typed: false
# frozen_string_literal: true

# A tiny cron with a memory: schedule any command, keep every result,
# recall on a timescale.
class Tulving < Formula
  desc "Tiny cron with a memory: schedule commands, keep results, recall"
  homepage "https://github.com/modiqo/tulving"
  version "0.1.3"
  license any_of: ["MIT", "Apache-2.0"]

  BASE = "https://github.com/modiqo/tulving/releases/download/v#{version}"

  on_macos do
    if Hardware::CPU.arm?
      url "#{BASE}/tulving-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "4eb7702da6c0d3c581d8049a1686d07f109bcecf7b5542c83a45b9e9aa7fd087"
    else
      url "#{BASE}/tulving-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "0b36b3b8a201ed12d9da25fd823ee7d90279713cab17c5a638f444b37e1e0fe9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "#{BASE}/tulving-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3f023b0d89da3ad8f2baf85deb7fbdfa68c7bdeea796968094bf5655e63c21f0"
    else
      url "#{BASE}/tulving-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "907b2ff35b66bfbc0a88a53a41edebe1ad5c4200c62c701b9f3bc2c6e67e5748"
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
