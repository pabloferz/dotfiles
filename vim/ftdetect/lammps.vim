" vim lammps filetype detection
"
augroup filetypedetect

au! BufNewFile,BufRead *.lmp
    \ set filetype=lammps

augroup END
