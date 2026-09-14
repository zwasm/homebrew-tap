class Zwasm < Formula
  desc "From-scratch WebAssembly runtime in Zig (Wasm 3.0, WASI, JIT + AOT)"
  homepage "https://github.com/zwasm/zwasm"
  license "Apache-2.0"

  on_macos do
    # Only an arm64 binary is published, and this rejects Intel by name.
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.7.0/zwasm-macos-aarch64.tar.gz"
      sha256 "2c01b5e8f8619b64413cc3e8843645963c961bde16476f40cd4c1f5b3b77408b"
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
      url "https://github.com/zwasm/zwasm/releases/download/v2.7.0/zwasm-macos-aarch64.tar.gz"
      sha256 "2c01b5e8f8619b64413cc3e8843645963c961bde16476f40cd4c1f5b3b77408b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/zwasm/zwasm/releases/download/v2.7.0/zwasm-linux-x86_64.tar.gz"
      sha256 "b76ada00016130d9d91f5721bfa8b5beacf6129921f9fc2a2c531ad18b2db57d"
    end
    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.7.0/zwasm-linux-aarch64.tar.gz"
      sha256 "7a113b650fd28bea3cca4225d22caef8fc71b946c9568dc5aee9bcaeb791bfba"
    end
  end

  def install
    bin.install "zwasm"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zwasm --version")
  end
end
