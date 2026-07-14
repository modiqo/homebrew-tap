class WaggleCli < Formula
  desc "The waggle CLI: the clap projection of the operations catalog. Ships `waggle` (verbs) and, from CP-6, `waggled` (the local daemon) and the stdio shim."
  homepage "https://github.com/modiqo/waggle"
  version "0.5.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.3/waggle-cli-aarch64-apple-darwin.tar.xz"
      sha256 "dfaccd93da593ad9a71025a83fe477f99f31ab39944774effa30a08a6085b3a8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.3/waggle-cli-x86_64-apple-darwin.tar.xz"
      sha256 "13ebd0c4f47885742a0591979d82258c31449fada8c94f8bb076918ba73e3697"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.3/waggle-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8727fc371ec3d4f33e0c70ad6cf5f8a8ac4ecadc6d6b50edb0ff52c54ceee3f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.3/waggle-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b8e2fc50c75d2c0dd93cf67da0cddf1b2cd79135d1cfa8107baf71071c729c08"
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
