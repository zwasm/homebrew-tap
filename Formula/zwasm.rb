class Zwasm < Formula
  desc "From-scratch WebAssembly runtime in Zig (Wasm 3.0, WASI, JIT + AOT)"
  homepage "https://github.com/zwasm/zwasm"
  license "Apache-2.0"

  on_macos do
    # Only an arm64 binary is published, and this rejects Intel by name.
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.5.0/zwasm-macos-aarch64.tar.gz"
      sha256 "22c7ba960d8d5b6a10ef978a3d6766d34bd30b726678880e4de7edf8674f9310"
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
      url "https://github.com/zwasm/zwasm/releases/download/v2.5.0/zwasm-macos-aarch64.tar.gz"
      sha256 "22c7ba960d8d5b6a10ef978a3d6766d34bd30b726678880e4de7edf8674f9310"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/zwasm/zwasm/releases/download/v2.5.0/zwasm-linux-x86_64.tar.gz"
      sha256 "fa7bc6a35ead2919385763ad0afea928f5ea7770764b648db9bc73ec492410b5"
    end
    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.5.0/zwasm-linux-aarch64.tar.gz"
      sha256 "4afc3f45ac7b9386246df8158ae45757cf0dd0191a40b01c24448076d8918796"
    end
  end

  def install
    bin.install "zwasm"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zwasm --version")
  end
end
