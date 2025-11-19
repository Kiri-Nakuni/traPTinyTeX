$latex = 'uplatex -synctex=1 -shell-escape -interaction=batchmode -file-line-error %O %S';
$bibtex = 'bibtexu %O %B';
$makeindex = 'upmendex %O -o %D %S';
$pdf_mode = 3;
$dvipdf = 'dvipdfmx %O -o %D %S';
$max_repeat = 10;
$ENV{"LANG"} = "ja_JP.UTF-8";