class Zwasm < Formula
  desc "From-scratch WebAssembly runtime in Zig (Wasm 3.0, WASI, JIT + AOT)"
  homepage "https://github.com/zwasm/zwasm"
  license "Apache-2.0"

  on_macos do
    # Only an arm64 binary is published, and this rejects Intel by name.
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.12.0/zwasm-macos-aarch64.tar.gz"
      sha256 "1ea773d0438e419868a009d4208a94e10a5b88c4108dec7c3f7b8c9d37f90871"
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
      url "https://github.com/zwasm/zwasm/releases/download/v2.12.0/zwasm-macos-aarch64.tar.gz"
      sha256 "1ea773d0438e419868a009d4208a94e10a5b88c4108dec7c3f7b8c9d37f90871"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/zwasm/zwasm/releases/download/v2.12.0/zwasm-linux-x86_64.tar.gz"
      sha256 "99aa2bbb4b406d2bc089d0bb9b37ddaa8f9a8d6c436fad6528314a51ebf097d4"
    end
    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.12.0/zwasm-linux-aarch64.tar.gz"
      sha256 "10e5f863eae9813f94b9aa2e04fb0a87a9fe54557fe61cf10a51c8432ecca1a2"
    end
  end

  def install
    bin.install "zwasm"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zwasm --version")
  end
end
