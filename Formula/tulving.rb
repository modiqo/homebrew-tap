# typed: false
# frozen_string_literal: true

# A tiny cron with a memory: schedule any command, keep every result,
# recall on a timescale.
class Tulving < Formula
  desc "Tiny cron with a memory: schedule commands, keep results, recall"
  homepage "https://github.com/modiqo/tulving"
  version "0.1.4"
  license any_of: ["MIT", "Apache-2.0"]

  BASE = "https://github.com/modiqo/tulving/releases/download/v#{version}"

  on_macos do
    if Hardware::CPU.arm?
      url "#{BASE}/tulving-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "5881a8f218a534177af393fe9fc866f76e1b14d93e9318327991e3cf896fba34"
    else
      url "#{BASE}/tulving-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "242d63025f00c93e02d38b7cfe3460059110e32aa14fbcafe7c642c63f71875f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "#{BASE}/tulving-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "32848612e0a542f35e45caba83acdd6c53a924ae9627d2ffa4fab3d4c74596c1"
    else
      url "#{BASE}/tulving-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "22fa5e966feec32e4c572f1cbaefda21ca2ef2ae91d26f4faec6e4a17b5122bb"
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
