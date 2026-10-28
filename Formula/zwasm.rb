class Zwasm < Formula
  desc "From-scratch WebAssembly runtime in Zig (Wasm 3.0, WASI, JIT + AOT)"
  homepage "https://github.com/zwasm/zwasm"
  license "Apache-2.0"

  on_macos do
    # Only an arm64 binary is published, and this rejects Intel by name.
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.8.0/zwasm-macos-aarch64.tar.gz"
      sha256 "b211b9f431bf399b1e6136ca141e3cff038f622ab05ad0de60c3fc4011a73bdf"
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
      url "https://github.com/zwasm/zwasm/releases/download/v2.8.0/zwasm-macos-aarch64.tar.gz"
      sha256 "b211b9f431bf399b1e6136ca141e3cff038f622ab05ad0de60c3fc4011a73bdf"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/zwasm/zwasm/releases/download/v2.8.0/zwasm-linux-x86_64.tar.gz"
      sha256 "21d1c627fc4b5ad98094b15891836f99daa3559d26eadf624d0e7f7935553965"
    end
    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.8.0/zwasm-linux-aarch64.tar.gz"
      sha256 "312873d9b409b8486be00e6ffa667d62ab552cab885e834beb48aea6f957de4f"
    end
  end

  def install
    bin.install "zwasm"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zwasm --version")
  end
end
