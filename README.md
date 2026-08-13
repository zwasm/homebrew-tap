# zwasm/homebrew-tap

Homebrew tap for [zwasm](https://github.com/zwasm/zwasm), a from-scratch
WebAssembly runtime in Zig.

## Install

```sh
brew install zwasm/tap/zwasm
```

Supported: macOS arm64, Linux x86_64 and Linux aarch64. Windows builds are on
the [Releases](https://github.com/zwasm/zwasm/releases) page rather than here.

## Moving from the old tap

zwasm used to ship from `clojurewasm/tap`. If you installed it that way,
`brew update` will point you at the new tap. To move by hand:

```sh
brew tap zwasm/tap
brew reinstall zwasm
```

## Gatekeeper

The binaries are not code-signed. Homebrew installs them without a Gatekeeper
prompt on most setups; if macOS still blocks one as coming from an unidentified
developer, clear the quarantine flag once:

```sh
xattr -d com.apple.quarantine "$(which zwasm)"
```

## License

Apache-2.0, the same license as zwasm itself.
