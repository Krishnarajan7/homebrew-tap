class Glimps < Formula
  desc "Zero-config smart terminal output formatter — auto-detects and reformats JSON, HTML, and logs live in your shell."
  homepage "https://github.com/Krishnarajan7/Glimps"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Krishnarajan7/Glimps/releases/download/v0.1.0/glimps-aarch64-apple-darwin.tar.xz"
      sha256 "e8a0439220c812d9939686f978d398d5664aa4a8f0d9c633169b4fa58135c458"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Krishnarajan7/Glimps/releases/download/v0.1.0/glimps-x86_64-apple-darwin.tar.xz"
      sha256 "331dd8f2a22487d8fa8aa9c8d06bf53f1f802f90624437e01db890587c0bbd46"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Krishnarajan7/Glimps/releases/download/v0.1.0/glimps-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1836d0de47260b8fb97d6ec53bc6958b246cb0c17efbc2e595de7b1010157510"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Krishnarajan7/Glimps/releases/download/v0.1.0/glimps-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c750db75be00e2a09fc042e39671529010f90ffc66663c8bf17d3ea2174bd519"
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
