class Zwasm < Formula
  desc "From-scratch WebAssembly runtime in Zig (Wasm 3.0, WASI, JIT + AOT)"
  homepage "https://github.com/zwasm/zwasm"
  license "Apache-2.0"

  on_macos do
    # Only an arm64 binary is published, and this rejects Intel by name.
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.11.1/zwasm-macos-aarch64.tar.gz"
      sha256 "70c28fd37d1a320a6dab50a8af536282ef656e74959cc569389638415327844d"
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
      url "https://github.com/zwasm/zwasm/releases/download/v2.11.1/zwasm-macos-aarch64.tar.gz"
      sha256 "70c28fd37d1a320a6dab50a8af536282ef656e74959cc569389638415327844d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/zwasm/zwasm/releases/download/v2.11.1/zwasm-linux-x86_64.tar.gz"
      sha256 "fa962d13147a758d0f01934dcdd0237f9139ad3557216fad0dfabf1188cac188"
    end
    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.11.1/zwasm-linux-aarch64.tar.gz"
      sha256 "49d5956fe94094873021614926a5475ba4975342e6c6aaa6b42744cd8d44758a"
    end
  end

  def install
    bin.install "zwasm"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zwasm --version")
  end
end
