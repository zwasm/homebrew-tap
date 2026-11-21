class Zwasm < Formula
  desc "From-scratch WebAssembly runtime in Zig (Wasm 3.0, WASI, JIT + AOT)"
  homepage "https://github.com/zwasm/zwasm"
  license "Apache-2.0"

  on_macos do
    # Only an arm64 binary is published, and this rejects Intel by name.
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.12.1/zwasm-macos-aarch64.tar.gz"
      sha256 "3d6c8df4683b685356312ea3400b7e1eaee51857f42a15b3f9d849f733d28fd9"
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
      url "https://github.com/zwasm/zwasm/releases/download/v2.12.1/zwasm-macos-aarch64.tar.gz"
      sha256 "3d6c8df4683b685356312ea3400b7e1eaee51857f42a15b3f9d849f733d28fd9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/zwasm/zwasm/releases/download/v2.12.1/zwasm-linux-x86_64.tar.gz"
      sha256 "a7bcc320fe4080975bf060302841544d865a4c02ac1dc6b0913fa635c70e86bd"
    end
    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.12.1/zwasm-linux-aarch64.tar.gz"
      sha256 "6b36cd6212dd4ce8f823dc6805ecbee92622e383ba4a194118a0daa8c8592609"
    end
  end

  def install
    bin.install "zwasm"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zwasm --version")
  end
end
