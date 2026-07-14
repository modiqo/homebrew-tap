class WaggleTmux < Formula
  desc "The seamless switchboard: move outcomes between Claude Code, Codex, and other tmux-resident harnesses as waggle tokens — minted in one gesture, resolved by the act of switching."
  homepage "https://github.com/modiqo/waggle"
  version "0.5.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.3/waggle-tmux-aarch64-apple-darwin.tar.xz"
      sha256 "38d9eb6cff91eb4f65dbaa991f6e38311893c278910ba294f2714523e88ef082"
    end
    if Hardware::CPU.intel?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.3/waggle-tmux-x86_64-apple-darwin.tar.xz"
      sha256 "51afb10af9bf680708d0f04b4279569f1bf2e7b9b7779ced72db3e71c8f0d196"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.3/waggle-tmux-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3779da98a334f62d5a9f94f8a70650786398eae026e47ebf409c43d859751e00"
    end
    if Hardware::CPU.intel?
      url "https://github.com/modiqo/waggle/releases/download/v0.5.3/waggle-tmux-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "88b291c6578f4b69e9e1c171b7ca69ac04870287404e42de62b85f2f45430dcc"
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
    bin.install "waggle-tmux" if OS.mac? && Hardware::CPU.arm?
    bin.install "waggle-tmux" if OS.mac? && Hardware::CPU.intel?
    bin.install "waggle-tmux" if OS.linux? && Hardware::CPU.arm?
    bin.install "waggle-tmux" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
