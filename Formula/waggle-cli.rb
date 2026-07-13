class WaggleCli < Formula
  desc "The waggle CLI: the clap projection of the operations catalog. Ships `waggle` (verbs) and, from CP-6, `waggled` (the local daemon) and the stdio shim."
  homepage "https://github.com/modiqo/waggle"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.2/waggle-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c563e0a559762839c20b54457f61ac8726b9332054caac663b1ea1bed10c54b6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.2/waggle-cli-x86_64-apple-darwin.tar.xz"
      sha256 "48c7a87d41164eccb7b9b3068655dd7225dc1714686630a64d2750b3baeb8ea4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.2/waggle-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d68cb61a6fc207c8619dec28c7137b48d18aed745e17630f9d121fd6b674860e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.2/waggle-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "81ba5a054d81badc39d0742e4713d80414ec46e09de6ab160303d40aefe19f62"
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
