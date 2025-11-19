$latex = 'uplatex -synctex=1 -shell-escape -interaction=batchmode -file-line-error %O %S';
$lualatex = 'lualatex -synctex=1 -shell-escape -interaction=batchmode -file-line-error %O %S'; 
$bibtex = 'bibtexu %O %B';
$makeindex = 'upmendex %O -o %D %S';
$pdf_mode = 3;
$dvipdf = 'dvipdfmx %O -o %D %S';
$max_repeat = 10;
$ENV{"LANG"} = "ja_JP.UTF-8";
$out_dir = 'pdf_out';
# for PythonTeX
$clean_ext .= " pythontex-files-%R/* pythontex-files-%R";
push @generated_exts, 'pytxcode', 'nav', 'snm', 'vrb', 'pyg', 'listing';
push @generated_exts, '_minted-%R/*';
$pythontex = 'pythontex %O %S';
$extra_rule_spec{'pythontex'}  = [ 'internal', '', 'mypythontex', "%Y%R.pytxcode",  "%Ypythontex-files-%R/%R.pytxmcr",    "%R", 1 ];

sub mypythontex {
   my $result_dir = $aux_dir1."pythontex-files-$$Pbase";
   my $ret = Run_subst( $pythontex, 2 );
   rdb_add_generated( glob "$result_dir/*" );
   open( my $fh, "<", $$Pdest );
   if ($fh) {
      while (<$fh>) {
         if ( /^%PythonTeX dependency:\s+'([^']+)';/ ) {
             print "Found pythontex dependency '$1'\n";
             rdb_ensure_file( $rule, $aux_dir1.$1 );
         }
      }
      undef $fh;
   }
   else {
       warn "mypythontex: I could not read '$$Pdest'\n",
            "  to check dependencies\n";
   }
   return $ret;
}