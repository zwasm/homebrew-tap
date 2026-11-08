class Zwasm < Formula
  desc "From-scratch WebAssembly runtime in Zig (Wasm 3.0, WASI, JIT + AOT)"
  homepage "https://github.com/zwasm/zwasm"
  license "Apache-2.0"

  on_macos do
    # Only an arm64 binary is published, and this rejects Intel by name.
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.10.0/zwasm-macos-aarch64.tar.gz"
      sha256 "6238780a0abb74c0ccf61a3ac83af3d7d63822142058ddf689a0c6ff75c58e17"
    end

    # Deliberate duplicate, and not a candidate for cleanup. Homebrew resolves
    # a spec while *loading* the formula, well before `depends_on` runs, so an
    # Intel Mac with no url here dies with "formula requires at least a URL", a
    # backtrace, and an invitation to report a Homebrew bug. Giving Intel a url
    # lets the formula load so the requirement above can produce "Required:
    # arm64 architecture" instead. It is never fetched. Hoisting the url up to
    # `on_macos` to avoid repeating it fails `brew style`:
    # FormulaAudit/ComponentsOrder allows url only inside on_arm / on_intel.
    on_intel do
      url "https://github.com/zwasm/zwasm/releases/download/v2.10.0/zwasm-macos-aarch64.tar.gz"
      sha256 "6238780a0abb74c0ccf61a3ac83af3d7d63822142058ddf689a0c6ff75c58e17"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/zwasm/zwasm/releases/download/v2.10.0/zwasm-linux-x86_64.tar.gz"
      sha256 "562de0dc41935ea14a8b8722801efb3e8481c1c915aa5fcc8249858ba2a608f1"
    end
    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.10.0/zwasm-linux-aarch64.tar.gz"
      sha256 "5f395fbb7433bca6a7589f7cac181de6b36cb8a66473cf8546bc6934b59c25fa"
    end
  end

  def install
    bin.install "zwasm"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zwasm --version")
  end
end
