class Zwasm < Formula
  desc "From-scratch WebAssembly runtime in Zig (Wasm 3.0, WASI, JIT + AOT)"
  homepage "https://github.com/zwasm/zwasm"
  license "Apache-2.0"

  on_macos do
    # Only an arm64 binary is published. The url stays at this level rather
    # than nested in an `on_arm` block so the formula still loads on Intel,
    # where `depends_on` then rejects it by name. Nested, Intel macOS reaches
    # `determine_active_spec` with no url at all and dies with "formula
    # requires at least a URL" plus a backtrace telling the user to file a bug.
    depends_on arch: :arm64

    url "https://github.com/zwasm/zwasm/releases/download/v2.5.0/zwasm-macos-aarch64.tar.gz"
    sha256 "22c7ba960d8d5b6a10ef978a3d6766d34bd30b726678880e4de7edf8674f9310"
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
