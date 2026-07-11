class WaggleCli < Formula
  desc "The waggle CLI: the clap projection of the operations catalog. Ships `waggle` (verbs) and, from CP-6, `waggled` (the local daemon) and the stdio shim."
  homepage "https://github.com/modiqo/waggle"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/modiqo/waggle/releases/download/v0.4.0/waggle-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d0212c6bcfb3edfd84f36ec410c60b639d48bad6cf3c6a98dcc771d7d3360005"
    end
    if Hardware::CPU.intel?
      url "https://github.com/modiqo/waggle/releases/download/v0.4.0/waggle-cli-x86_64-apple-darwin.tar.xz"
      sha256 "7d9ed6504aad9b12e3f0e907f46e4522f1d920038cfa2a7fac9a3d775a1fb710"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/modiqo/waggle/releases/download/v0.4.0/waggle-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d451ebf3b6db62fa3d0c5330db421cf2936d5b96ac73c444d109eae4b6be9fe7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/modiqo/waggle/releases/download/v0.4.0/waggle-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ff7c120425df62aba55cd44ce2802f7055c6cc04cad4c8e755e4645b9a7cc616"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "waggle"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "waggle"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "waggle"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "waggle"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
