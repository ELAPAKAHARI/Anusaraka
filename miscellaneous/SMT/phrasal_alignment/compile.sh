gcc -o gdbm-fetch.out gdbm-fetch.c -lgdbm
$HOME_anu_test/Anu_data/create-gdbm.pl  en-hi-gdbm-dict.gdbm < en-hi-gdbm-dict.txt
cd $HOME_anu_test/multifast-v1.0.0/src/
make
