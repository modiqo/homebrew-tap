class WaggleCli < Formula
  desc "The waggle CLI: the clap projection of the operations catalog. Ships `waggle` (verbs) and, from CP-6, `waggled` (the local daemon) and the stdio shim."
  homepage "https://github.com/modiqo/waggle"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.1/waggle-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b4f8e747e997003720aebfafd1cca991fc80f637ced3c3fbe29f3e4d484bbdb9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.1/waggle-cli-x86_64-apple-darwin.tar.xz"
      sha256 "3ac6ed00d3de3c6652616333e7fcbeae35dd65e065e56c079aad85fbf4524e63"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.1/waggle-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8f1082bb83a5ac034b37ab7ef3409c58c732a75e42d3ad259ae9da0e3771050e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.1/waggle-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ce707400fe08b09ed4ca1b32ecafeba403f110b3d97946aacc9c7e35a0da247b"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "waggle" if OS.mac? && Hardware::CPU.arm?
    bin.install "waggle" if OS.mac? && Hardware::CPU.intel?
    bin.install "waggle" if OS.linux? && Hardware::CPU.arm?
    bin.install "waggle" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
