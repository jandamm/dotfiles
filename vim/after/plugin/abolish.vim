if exists('g:loaded_abolish_after')
	finish
endif
let g:loaded_abolish_after = 1

Abolish {inst,h,r}aed{,er,ing,y,ily} {}ead{}
Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or} {despe,sepa}rat{}
Abolish {in,}contin{u,o,ou,uo,uu}s{,ly} {}contin{uou}s{}
Abolish {un,}ne{c,cc}es{,s}ar{y,ily,ity} {}ne{c}es{s}ar{}
