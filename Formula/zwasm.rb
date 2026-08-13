class Zwasm < Formula
  desc "From-scratch WebAssembly runtime in Zig (Wasm 3.0, WASI, JIT + AOT)"
  homepage "https://github.com/zwasm/zwasm"
  license "Apache-2.0"

  on_macos do
    # No x86_64-macos binary is published, so fail on Intel with a clear
    # message instead of an unresolved url.
    depends_on arch: :arm64

    on_arm do
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
