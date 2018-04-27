#!/usr/bin/env perl
$latex = 'uplatex %O -synctex=1 -interaction=nonstopmode %S';
$pdflatex = 'lualatex %O -synctex=1 -interaction=nonstopmode %S';
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$bibtex = 'upbibtex %O %B';
$makeindex = 'upmendex %O -o %D %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
$dvips = 'dvips %O -z -f %S | convbkmk -u > %D';
$ps2pdf = 'ps2pdf %O %S %D';
$pdf_mode = 3;
$pdf_previewer = 'evince'

#$latex = 'platex -synctex=1 %O %S';
#$bibtex = 'pbibtex %O %B';
#$dvipdf = 'dvipdfmx %O -o %D %S';
#$makeindex = 'mendex %O -o %D %S';
#$max_repeat = 10;

#$latex            = 'uplatex -synctex=1 -halt-on-error';
#$latex_silent     = 'uplatex -synctex=1 -halt-on-error -interaction=batchmode';
#$bibtex           = 'upbibtex';
#$biber            = 'biber --bblencoding=utf8 -u -U --output_safechars';
#$dvipdf           = 'dvipdfmx %O -o %D %S';
#$makeindex        = 'mendex %O -o %D %S';
#$max_repeat       = 5;
#$pdf_mode         = 3;
#$pvc_view_file_via_temporary = 0;
#$pdf_previewer = 'evince'
