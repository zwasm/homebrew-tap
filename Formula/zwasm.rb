class Zwasm < Formula
  desc "From-scratch WebAssembly runtime in Zig (Wasm 3.0, WASI, JIT + AOT)"
  homepage "https://github.com/zwasm/zwasm"
  license "Apache-2.0"

  on_macos do
    # Only an arm64 binary is published, and this rejects Intel by name.
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.8.1/zwasm-macos-aarch64.tar.gz"
      sha256 "79e6ca595f2924ac1f0fe6918d010fa1ba79e956ba9f76de2aacbcf1b6ee8742"
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
      url "https://github.com/zwasm/zwasm/releases/download/v2.8.1/zwasm-macos-aarch64.tar.gz"
      sha256 "79e6ca595f2924ac1f0fe6918d010fa1ba79e956ba9f76de2aacbcf1b6ee8742"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/zwasm/zwasm/releases/download/v2.8.1/zwasm-linux-x86_64.tar.gz"
      sha256 "67ecabd8d0c437a4e6a5a70bb051743670c980d4db4275cb0e1ee85bcba74a83"
    end
    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.8.1/zwasm-linux-aarch64.tar.gz"
      sha256 "b13e4bb37e8bd72724fd70eef06592c3fe2f3972389f03f3afb9e02d17b7d5f8"
    end
  end

  def install
    bin.install "zwasm"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zwasm --version")
  end
end
