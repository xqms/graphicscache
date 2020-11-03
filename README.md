# graphicscache

This LaTeX package provides caching of `\includegraphics` calls, with several
useful effects:

* Recompilations are much faster (10x speedup observed)
* Images can be postprocessed with `ghostscript` before inclusion, thus:
  * Automatic downscaling to specified DPI
  * Automatic JPEG compression with configurable quality
  * Much smaller files (e.g. 10MB instead of 150MB)!

Note: Due to the one-by-one invocation of `pdflatex` and `ghostscript` for
each graphics element, the first compilation is typically slower than usual.

Note: graphicscache needs the `\write18` call (also called shell escape). This
is a security risk if you have untrusted TeX sources.

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

and you are finished. Remember to compile your document with `-shell-escape`,
like

    pdflatex -shell-escape paper.tex

Most LaTeX editors allow you to enable shell escape in their settings.

## Releasing

Another feature is creating a "release" tarball containing your TeX sources
and the downscaled images. Just use the `release.sh` shell script in your source
directory. In this case it is recommended to place the `graphicscache.sty` file
in your source tree, since your release target will probably not have it.

    # first copy graphicscache.sty and release.sh into your paper directory
    cp ...
    
    # then release!
    bash release.sh paper.tex

After checking `test_release/submission.pdf`, the file `release.tar` can be uploaded
to arXiv (they will extract it automatically).

## Documentation

For more information, check the package documentation, which you can generate
with:

    pdflatex graphicscache.dtx
