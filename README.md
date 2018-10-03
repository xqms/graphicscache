# graphicscache

This LaTeX package provides caching of `\includegraphics` calls, with several
useful effects:

* Recompilations are much faster (10x speedup observed)
* Images can be postprocessed with `ghostscript` before inclusion, thus:
  * Automatic downscaling to specified DPI
  * Automatic JPEG compression
  * Much smaller files!

Note: Due to the one-by-one invocation of `pdflatex` and `ghostscript` for
each graphics element, the first compilation is typically slower than usual.

## Quickstart

Compile the package using

    latex graphicscache.ins

to generate the file `graphicscache.sty`, which you should place in your TeX
input path. On Unix systems, this can be done by:

    mkdir -p ~/texmf/tex/latex/graphicscache
    cp graphicscache.sty ~/texmf/tex/latex/graphicscache/
    texhash

Or just drop the graphicscache.sty next to your TeX document.

Activate caching with

    \usepackage{graphicscache}

and you are finished!

## Releasing

Another feature is creating a "release" tarball containing your TeX sources
and the downscaled images. Just use the `release.sh` shell script in your source
directory.

## Documentation

For more information, check the package documentation, which you can generate
with:

    pdflatex graphicscache.dtx
