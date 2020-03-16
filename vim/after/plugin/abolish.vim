if exists('g:loaded_abolish_after')
	finish
endif
let g:loaded_abolish_after = 1

Abolish {h,r}aed{,er,ing}             {h,r}ead{}

" Abolish contin{u,o,ou,uo,uu}s{,ly}       contin{uou}s{}
iabbrev continusly        continuously
iabbrev continosly        continuously
iabbrev continously       continuously
iabbrev continuosly       continuously
iabbrev continuusly       continuously
iabbrev continus          continuous
iabbrev continos          continuous
iabbrev continous         continuous
iabbrev continuos         continuous
iabbrev continuus         continuous

iabbrev Continusly        Continuously
iabbrev Continosly        Continuously
iabbrev Continously       Continuously
iabbrev Continuosly       Continuously
iabbrev Continuusly       Continuously
iabbrev Continus          Continuous
iabbrev Continos          Continuous
iabbrev Continous         Continuous
iabbrev Continuos         Continuous
iabbrev Continuus         Continuous

iabbrev CONTINUSLY        CONTINUOUSLY
iabbrev CONTINOSLY        CONTINUOUSLY
iabbrev CONTINOUSLY       CONTINUOUSLY
iabbrev CONTINUOSLY       CONTINUOUSLY
iabbrev CONTINUUSLY       CONTINUOUSLY
iabbrev CONTINUS          CONTINUOUS
iabbrev CONTINOS          CONTINUOUS
iabbrev CONTINOUS         CONTINUOUS
iabbrev CONTINUOS         CONTINUOUS
iabbrev CONTINUUS         CONTINUOUS
