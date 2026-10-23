class Aeth < Formula
  desc "Aetherial command line (MCP client)"
  homepage "https://docs.aetherial.events/admin/integrations/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/erwins-enkel/aeth/releases/download/aeth-v0.1.0/aeth-aarch64-apple-darwin.tar.xz"
      sha256 "07565ea5e31e487672bdf19aefc1d45762b533623e6696511930a4423eced1de"
    end
    if Hardware::CPU.intel?
      url "https://github.com/erwins-enkel/aeth/releases/download/aeth-v0.1.0/aeth-x86_64-apple-darwin.tar.xz"
      sha256 "abd3091befd36145912d4a7e0d9eff1dbc595539da4f32601f755adb2fbbebd1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/erwins-enkel/aeth/releases/download/aeth-v0.1.0/aeth-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e4c12246c78286bef19546c294b08da7a9d8b131768563217f9c4467801a0b20"
    end
    if Hardware::CPU.intel?
      url "https://github.com/erwins-enkel/aeth/releases/download/aeth-v0.1.0/aeth-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "41fcae4ceda2ca8ae2c52d787a7292779bfd7b42baae3a5c3974dd7eacef1f7a"
    end
  end
  license "UNLICENSED"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
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
      bin.install "aeth"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "aeth"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "aeth"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "aeth"
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
