####Any changes done in stdenglish/abbr1.lex should be updated here also.


sed 's/(Eng_sen \"//g' English_sentence.dat | sed  's/\")//g'|sed 's/&quot;/\"/g'|  sed 's/\&amp;/&/g'|sed 's/DOTDOTDOT/.../g' | sed 's/DOTDOTDOT/.../g'|  sed 's/ABBRThatis/i.e./g' | sed 's/aABBRDOTABBRkABBRDOTABBRaABBRDOTABBR/a.k.a./g' | sed 's/eABBRDOTABBRgABBRDOTABBR/e.g./g'|  sed 's/TWTWTWTW/_/g' |  sed 's/TWTW/ /g' | sed 's/UABBRDOTABBRSABBRDOTABBR/U.S./g' | sed 's/UABBRDOTABBRSABBRDOTABBRAABBRDOTABBR/U.S.A./g' | sed 's/UABBRDOTABBRKABBRDOTABBR/U.K./g' | sed 's/AABBRDOTABBRDABBRDOTABBR/A.D./g' |  sed 's/SrABBRDOT/Sr./g' |  sed 's/JrABBRDOT/Jr./g' | sed 's/DrABBRDOT/Dr./g' |  sed 's/MrABBRDOT/Mr./g' | sed 's/MrsABBRDOT/Mrs./g' | sed 's/ABBRDOT/./g' | sed 's/THREEDOTS/\.\.\./g'


 cat  hindi_sentence.dat | sed  's/right_paren,/)/g' | sed  's/)\./\./g'|sed  's/equal_to/=/g'|sed  's/left_paren/(/g'|sed  's/right_paren/)/g' |sed  's/\")//g'|sed 's/&quot;/\"/g'|sed 's/\&amp;/&/g'|sed 's/DOTDOTDOT/.../g'| sed 's/ABBRThatis/i.e./g' | sed 's/aABBRDOTABBRkABBRDOTABBRaABBRDOTABBR/a.k.a./g' | sed 's/eABBRDOTABBRgABBRDOTABBR/e.g./g'| sed 's/TWTWTWTW/_/g' | sed 's/TWTW/ /g' | sed -e 's/\\@//g' | sed 's/UABBRDOTABBRSABBRDOTABBR/U.S./g' | sed 's/UABBRDOTABBRSABBRDOTABBRAABBRDOTABBR/U.S.A./g' | sed 's/UABBRDOTABBRKABBRDOTABBR/U.K./g' | sed 's/AABBRDOTABBRDABBRDOTABBR/A.D./g' |  sed 's/SrABBRDOT/Sr./g' |  sed 's/JrABBRDOT/Jr./g' | sed 's/DrABBRDOT/Dr./g' |  sed 's/MrABBRDOT/Mr./g' | sed 's/MrsABBRDOT/Mrs./g' | sed 's/ABBRDOT/./g' >hindi_sentence1.dat |  sed 's/THREEDOTS/\.\.\./g'

