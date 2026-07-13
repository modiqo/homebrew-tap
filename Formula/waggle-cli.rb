class WaggleCli < Formula
  desc "The waggle CLI: the clap projection of the operations catalog. Ships `waggle` (verbs) and, from CP-6, `waggled` (the local daemon) and the stdio shim."
  homepage "https://github.com/modiqo/waggle"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.0/waggle-cli-aarch64-apple-darwin.tar.xz"
      sha256 "4e2b8c47367a8a7301297a6da4c9310c95634072920dce343a24c40b7ccb0a7b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.0/waggle-cli-x86_64-apple-darwin.tar.xz"
      sha256 "491f2afe3367c667cc7f1f0249745e160431e7a7d17b17c894f5a8cd5608a569"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.0/waggle-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4a0eecd1ea2822b20ca0f91b0c800a994b06713a7619998833ca5dd323470405"
    end
    if Hardware::CPU.intel?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.0/waggle-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9cafaae1a9a7211ed34e466d68f55f123d864e244ca45e372b3f81d3cbcf8e67"
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
