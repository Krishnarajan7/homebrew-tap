class Glimps < Formula
  desc "Zero-config smart terminal output formatter — auto-detects and reformats JSON, HTML, and logs live in your shell."
  homepage "https://github.com/Krishnarajan7/Glimps"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Krishnarajan7/Glimps/releases/download/v0.2.0/glimps-aarch64-apple-darwin.tar.xz"
      sha256 "ec1cc5c431a8c4e1a0e3a59d8b4b69776f8a7cf0ee97a87b9bc83ae42003bc7e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Krishnarajan7/Glimps/releases/download/v0.2.0/glimps-x86_64-apple-darwin.tar.xz"
      sha256 "8313da0ba10f53bb077ea230ec8a4922ed8ca2cc62f283cedffca3b417b02e32"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Krishnarajan7/Glimps/releases/download/v0.2.0/glimps-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6a6dfc48939829e1b4ca2ea14f6ba4344c9123b416a8604e6053c500817efc85"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Krishnarajan7/Glimps/releases/download/v0.2.0/glimps-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "aaef435827038a69674258d0b5105f1c6ab47ee7feec1e649696c58760af2085"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "glimps"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "glimps"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "glimps"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "glimps"
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
