class Zwasm < Formula
  desc "From-scratch WebAssembly runtime in Zig (Wasm 3.0, WASI, JIT + AOT)"
  homepage "https://github.com/zwasm/zwasm"
  license "Apache-2.0"

  on_macos do
    # Only an arm64 binary is published, and this rejects Intel by name.
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.9.0/zwasm-macos-aarch64.tar.gz"
      sha256 "c691afb9229b084690ee81e893dcf595832ddd704d48d9609cd092e3550fe5f0"
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
      url "https://github.com/zwasm/zwasm/releases/download/v2.9.0/zwasm-macos-aarch64.tar.gz"
      sha256 "c691afb9229b084690ee81e893dcf595832ddd704d48d9609cd092e3550fe5f0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/zwasm/zwasm/releases/download/v2.9.0/zwasm-linux-x86_64.tar.gz"
      sha256 "4d4d83b6b6ea514178b63d78525bffffd4d82a33ac8437d46ae806aa9fef0a25"
    end
    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.9.0/zwasm-linux-aarch64.tar.gz"
      sha256 "dea4180673ff653dca7639813226d57b380f0a0f79f55774bf0ff97258569b8b"
    end
  end

  def install
    bin.install "zwasm"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zwasm --version")
  end
end
