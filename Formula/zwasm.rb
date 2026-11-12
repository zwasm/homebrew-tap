class Zwasm < Formula
  desc "From-scratch WebAssembly runtime in Zig (Wasm 3.0, WASI, JIT + AOT)"
  homepage "https://github.com/zwasm/zwasm"
  license "Apache-2.0"

  on_macos do
    # Only an arm64 binary is published, and this rejects Intel by name.
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.11.0/zwasm-macos-aarch64.tar.gz"
      sha256 "8fa13d666c442206a90f12f9fa2bf40abc4c4ce3e299a19c660b1bf3c36e8f9e"
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
      url "https://github.com/zwasm/zwasm/releases/download/v2.11.0/zwasm-macos-aarch64.tar.gz"
      sha256 "8fa13d666c442206a90f12f9fa2bf40abc4c4ce3e299a19c660b1bf3c36e8f9e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/zwasm/zwasm/releases/download/v2.11.0/zwasm-linux-x86_64.tar.gz"
      sha256 "1860dadf6351c148d5361c287cb498fed86dc8cbfb02646f4ddfc7d85c28fd3c"
    end
    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.11.0/zwasm-linux-aarch64.tar.gz"
      sha256 "f92005270129674a350c806a4c8c63f661765001235ef5eb582076160d3b705b"
    end
  end

  def install
    bin.install "zwasm"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zwasm --version")
  end
end
