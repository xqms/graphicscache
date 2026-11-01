# Release notes

## Unreleased (since v0.4)

### ⚠ Cache invalidation

- The cache key now includes the compression mode (and the new `flatten`,
  `cmyk` and `output icc profile` settings when used). **All existing cache
  files get new names after upgrading.**
  - With rendering enabled, everything is simply re-rendered once.
  - With rendering disabled (`render=false`, `\graphicscache@inhibit`, or an
    environment without shell escape such as arXiv/Overleaf), old cache files
    are no longer found and graphicscache falls back to the original images.
    Re-render the cache with the new version before releasing.

### New features

- `fullclip` option: crops bitmap images with ImageMagick so that only the
  visible part of a trimmed image ends up in the PDF (xfp is optional).
- `flatten` option: flatten transparency via ghostscript.
- `cmyk` option: convert colors and images to CMYK via ghostscript.
- `output icc profile=<file>` option: pass an output ICC profile to
  ghostscript.
- `compress=flate` as the correctly spelled name of the lossless mode
  (`compress=flat` remains as an alias).
- `disable` key and automatic detection of `pdfpages`; support for
  `width=!` / `height=!`.
- Listing format extended with the current file path and options.
- `alt` key (alternative text, e.g. set by the `markdown` package) is
  supported. It is not part of the cache key and is passed to the final
  inclusion of the cached PDF (ignored if `graphicx` does not know `alt`).
- Unsupported `\includegraphics` keys now produce a helpful error listing
  the supported keys. With `disable=true`, unsupported keys are passed through
  to the native `\includegraphics`. Unknown package options are reported as
  such.

### Fixes

- `compress=flat` passed the invalid filter name `FlatEncode` to
  ghostscript; it now uses `FlateEncode`.
- Each image is rendered via its own temporary files, so parallel
  compilations sharing a cache directory no longer overwrite each other.
  Temporary files are removed after rendering.
- Windows: shell commands use native (backslash) paths.
- Paths containing spaces (cache directory, ICC profile) are quoted.
- With `\graphicscache@inhibit`, source images are no longer accessed and
  hashes do not change.
- `currfile` is only required when `listing` is enabled.
- Removed spurious spaces and "Already have" info messages in the output.

### Documentation

- The default value of every key is shown next to its description.
- Documented the `disable` and `hashshortnames` keys.

### release.sh

- Runs LaTeX in a pinned TeX Live docker image (matching arXiv) if docker is
  available.
- Enables `hashshortnames` for releases.
- Automatically uses biber if required; handles file names with whitespace.
