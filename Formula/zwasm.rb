class Zwasm < Formula
  desc "From-scratch WebAssembly runtime in Zig (Wasm 3.0, WASI, JIT + AOT)"
  homepage "https://github.com/zwasm/zwasm"
  license "Apache-2.0"

  on_macos do
    # Only an arm64 binary is published, and this rejects Intel by name.
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.6.0/zwasm-macos-aarch64.tar.gz"
      sha256 "0cdb3af52f94dd000b154b7ce254f476f9810e2a435c95150bacd8051b5727be"
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
      url "https://github.com/zwasm/zwasm/releases/download/v2.6.0/zwasm-macos-aarch64.tar.gz"
      sha256 "0cdb3af52f94dd000b154b7ce254f476f9810e2a435c95150bacd8051b5727be"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/zwasm/zwasm/releases/download/v2.6.0/zwasm-linux-x86_64.tar.gz"
      sha256 "381a4eab574c4a0ca4ed0b6517884858c4143bc6cb184245390c9928a7deb76b"
    end
    on_arm do
      url "https://github.com/zwasm/zwasm/releases/download/v2.6.0/zwasm-linux-aarch64.tar.gz"
      sha256 "6ce60532026889eeafb0af0b90ba0ef140a3973fafe88142402efa85c6bd29e3"
    end
  end

  def install
    bin.install "zwasm"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zwasm --version")
  end
end
