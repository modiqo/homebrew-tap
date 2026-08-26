# typed: false
# frozen_string_literal: true

# A tiny cron with a memory: schedule any command, keep every result,
# recall on a timescale.
class Tulving < Formula
  desc "Tiny cron with a memory: schedule commands, keep results, recall"
  homepage "https://github.com/modiqo/tulving"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  BASE = "https://github.com/modiqo/tulving/releases/download/v#{version}"

  on_macos do
    if Hardware::CPU.arm?
      url "#{BASE}/tulving-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "2cb9b41c83fb629f35b97fe182127801bed6ef583d6450de592fe0ba999dce8f"
    else
      url "#{BASE}/tulving-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "6ec8aaa5b13ef0eee3ded425b157596405f96145fd5b76d2bd54b219e4750680"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "#{BASE}/tulving-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "709c669ab82f4fd30e7e77db1a76be4fcaf16270505bb670de43e4b3221290e5"
    else
      url "#{BASE}/tulving-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b7b2d26d24ee0a4dab1037d749035176adbaa9cba35f85a9e90d36229c2e35a2"
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
