+++
title = "Compile LaTeX documents with latexmk"

[extra]
author = "Zekun"
+++

{{ section_begin(header="Introduction") }}

In{% marginnote(unique_id="beginner") %}
Please note that this is not a beginner's guide to _LaTeX_.
If you're completely new and would like to give _LaTeX_ a try,
you can use online editors on [Tutorials Point](https://www.tutorialspoint.com/online_latex_editor.php)
or [Overleaf](https://www.overleaf.com/) (registration required).
If you already have _LaTeX_ installed on your machine (type _tex --version_ in the command line to see if you do),
this post provides minimal working example for you to produce a PDF file from a _LaTeX_ document;
no previous knowledge required.
{% end %}
this post I'll talk about using [`latexmk`](http://personal.psu.edu/~jcc8/software/latexmk/) to make compiling _LaTeX_ documents easier.
`latexmk` automates the workflow of running _LaTeX_ and other auxiliary commands the correct number of times,
which resolves cross references, starts a document viewer, and keeps updating when changes are made to the source files.

### Prerequisites
* Experience of using the command line
* An installed _TeX_ distribution
* `latexmk`, which should come with your _TeX_ distribution

{{ section_con(header="A minimal working example") }}

Create a `temp.tex` file with the following content in your current working directory:

```tex
\documentclass{article}

\begin{document}

A sample document.

\end{document}
```

You can use the command `pdflatex temp.tex` to produce a PDF file.
To use `latexmk` instead, type the following command:
`latexmk -pdf`{% sidenote(unique_id="omit-filename") %}
The __-pdf__ option tells _latexmk_ to generate PDF by pdflatex.
Also, you can leave out the file name when there's only one .tex file in the directory.
{% end %}.
You can clean up the generated auxiliary files by running `latexmk -c`.

The power of `latexmk` is yet to be revealed,
let's move on to more practical examples.

{{ section_con(header="Use latexmk with configurations") }}

`latexmk` becomes really handy with simple configurations.
To get started,
create an empty file named `.latexmkrc`{% sidenote(unique_id="run-commands") %}The term _rc_ stands for __[run commands](https://en.wikipedia.org/wiki/Run_commands)__.{% end %}
in the home directory with your text editor.
This could also be done using the command line:
type `cd` to change to your home directory,
then create an empty configuration file by typing `touch .latexmkrc`.

### Set document viewer for continuous preview

Set the document viewer of your choice{% sidenote(unique_id="macOS-preview") %}
If you are on macOS,
no configuration is needed at the moment,
as Preview is the default viewer.
{% end %}, such as Evince or Okular, in `.latexmkrc`:

```txt
$pdf_previewer = 'okular';
```

Back in the directory in which the `temp.tex` resides,
start `latexmk`'s continuous preview mode using `latexmk -pdf --pvc`.
You will see that `latexmk` opens the PDF document compiled from your TeX source file with the viewer of your choice,
and keeps it updated with every saved edit you make.

### Simplified workflow of working with references

You usually need to manually run multiple commands in the command line
when compiling documents with references.
This can be taken care of by `latexmk`'s continuous preview mode.
Let's modify the `temp.tex` to include a reference and see it in action:

```tex
\documentclass{article}

\usepackage[backend=biber]{biblatex}

\usepackage{filecontents}

\begin{filecontents*}{temp.bib}
  @book{Knu86,
    author = {Knuth, Donald E.},
    year = {1986},
    title = {The \TeX book},
  }
\end{filecontents*}

\addbibresource{temp.bib}

\begin{document}

A sample document.
Please see The \TeX\ book~\cite{Knu86} for more information.

\printbibliography{}

\end{document}
```

To manually compile this expanded example{% sidenote(unique_id="tex-bib") %}
It uses the package _biblatex_ with _biber_ backend to process and format bibliographic information.
It also uses _filecontents_ to create an entry of bibliography, The TeX Book,
that can be used together with the .tex source file.
{% end %},
you will need to 

1. run `pdflatex temp.tex` first,
getting the warning that "there were undefined references";
2. then run `biber temp` to resolve the reference;
3. and run `pdflatex temp.tex` again to produce the final document that includes references.

This process gets repetitive when you constantly edit the source file and need to see the compiled result.
It's where `latexmk` comes to improve the quality of life of using _LaTeX_:

```
latexmk -pdf --pvc
```

this single line of command resolves the references and keeps the PDF document updated to your saved edits,
simplifying the above-mentioned tiring workflow.
To stop `latexmk`'s continuous preview mode,
press `Control + c` in the command line.

{{ section_con(header="Compile XeTeX files with latexmk") }}

_XeTeX_ (pronounced _/ZEE-tekh/_) is a UTF-8 engine{% sidenote(unique_id="tex-engines") %}
An alternative is _LuaTeX_, see [here](https://tex.stackexchange.com/questions/36/differences-between-luatex-context-and-xetex/72#72)
for an explanation on their differences.
{% end %} for processing _TeX_ documents.
It has better support for fonts and character sets out-of-the-box than _pdfTeX_.
To use `latexmk` with _XeTeX_, you will need some more configuration.
Let's update the `.latexmkrc` with the following content:

```txt
$pdf_previewer = 'okular';

$pdf_mode = 5;

$pdflatex = 'xelatex %O %S';

$dvi_mode = 0;

$postscript_mode = 0;

$allow_switch = 1;
```
This configuration works as follows:

* The first line specifies the document viewer; replace _okular_ with the one of your choice.
* The second and third lines{% sidenote(unique_id="latexmk-options") %}
Because _latexmk_ by default uses _xelatex_ to generate an _.xdv_ rather than _.pdf_ file
([_latexmk Manual_](https://ftp.heanet.ie/pub/ctan.org/tex/support/latexmk/latexmk.pdf), p 42),
to compile PDF files from _XeTeX_ documents you need to explicitly tell _latexmk_ to do so;
hence the two lines of configuration.
{% end %} tell _latexmk_ to generate the PDF file using _xelatex_.
* The fourth and fifth lines prevents _latexmk_ from generating DVI and PostScript files.
* The last line allows `latexmk` to make adjustments when the output extension is not expected.

Please see these two posts on
[Stack Exchange](https://tex.stackexchange.com/questions/27450/how-to-make-latexmk-work-with-xelatex-and-biber)
and [Stack Overflow](https://stackoverflow.com/questions/3124273/compile-xelatex-tex-file-with-latexmk) for further discussion;
and as always, [the manual](https://ftp.heanet.ie/pub/ctan.org/tex/support/latexmk/latexmk.pdf) is a good reference.

{{ section_con(header="Epilogue") }}

Hopefully this post is a starting point for me to write about my experience with open source tools for research and everyday use,
as stated on the [_about_](@/about/index.md) page.
I believe it's easier to find help when running into problem when using open source software.
Let's go blogging and make this belief stay alive!

