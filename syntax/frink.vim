if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case match

" Units
let s:prefixes = [
\    "yotta", "zetta", "exa", "peta",  "tera", "giga", "mega", "myria", "kilo",  "hecto", "deca", "deka",
\    "yocto", "zepto", "ato", "femto", "pico", "nano", "micro",         "milli", "centi", "deci",
\    ]

let s:oneletter_prefixes = [
\    "Y", "Z", "E", "P", "T", "G", "M", "k", "h",
\    "y", "z", "a", "f", "p", "n",  "m", "c", "d",
\    ]

" TODO: these will be prefixed, and frink will accept as valid, even when it might not make sense.
" Is `deciweek` a thing? Should it be?
let s:units = [
\   "meter", "meters", "metre", "metres", "m",
\   "gram", "grams", "gm", "gms", "g",
\   "ampere", "amperes", "amp", "amps", "A",
\   "kelvin", "kelvins", "K",
\   "dollar", "dollars",
\   "mol", "moles",
\   "radian", "radians",
\   "bit", "bits", "byte", "bytes",
\   "candela", "candelas", "cd",
\   "newton", "newtons", "N",
\   "pascal", "pascals", "Pa",
\   "joule", "joules", "J",
\   "watt", "watts", "W",
\   "coulomb", "coulombs", "C",
\   "volt", "volts", "V",
\   "ohm", "ohms", "Ω", "Ω",
\   "siemens", "S", "mho",
\   "farad", "farads", "F",
\   "weber", "webers", "Wb",
\   "henri", "henries", "H",
\   "tesla", "teslas", "T",
\   "hertz", "Hz",
\   "rpm", "rps",
\   "circle", "circles", "revolution", "revolutions", "rev", "revs", "turn", "turns",
\
\   "second", "seconds", "sec", "secs", "s",
\   "minute", "minutes", "min", "mins",
\   "hour",  "hours", "hr",
\   "day", "days", "d", "da",
\   "week", "weeks", "wk", "wks",
\   "sennight", "fortnight", "blink", "ce",
\
\   "inch", "inches", "in",
\   "foot", "feet", "ft",
\   "yard", "yards", "yd",
\   "mile", "miles", "statute", "statutemile", "statutemiles", "league", "leagues",
\   "line", "lines",
\   "rod", "rods", "rd",
\   "perch", "furlong", "furlongs",
\   "tonne", "tonnes", "ton", "tons", "t", "metricton",
\   "bar", "vac",
\   "micron", "bicron",
\   "cc",
\   "are",
\   "litre", "litres", "liter", "liters", "oldliter", "oldliters", "l", "L",
\
\   "cal", "cals", "calorie", "calories", "thermie", "thermies", "Calorie", "Calories",
\   "Btu", "Btus", "btu", "btus",
\   "eV", "eVs",
\
\   "angstrom", "Å", "Å",
\   "xunit", "xunits", "siegbahn", "siegbahns",
\   "fermi", "fermis", "barn", "barns", "shed", "sheds",
\   "brewster", "brewsters",
\
\   "diopter", "diopters", "fresnel", "fresnels",
\   "shake", "shakes", "svedberg", "svedbergs",
\
\   "planck",
\
\   "lakh", "lac", "crore"
\]

for unit in s:units
    exec "syn keyword frinkUnit " . unit
        for prefix in s:prefixes
            exec "syn keyword frinkUnit " . prefix . unit
        endfor
        for prefix in s:oneletter_prefixes
            exec "syn keyword frinkUnit " . prefix . unit
        endfor
endfor
for prefix in s:prefixes
    exec "syn keyword frinkUnit " . prefix
endfor

unlet s:units s:prefixes s:oneletter_prefixes

" Don't prefix:
syn keyword     frinkUnit   hectare, uF

" Literals
" TODO: can be plural
syn keyword     frinkInt    one two three four five six seven eight nine
syn keyword     frinkInt    ten twenty thirty fourty fifty sixty seventy ninety
syn keyword     frinkInt    hundred million thousand billion trillion
syn keyword     frinkInt    quadrillion quintillion sextillion septillion octillion nonillion noventillion
syn keyword     frinkInt    decillion undecillion duodecillion tredecillion quattuordecillion quindecillion
syn keyword     frinkInt    sexdecillion septendecillion octodecillion novemdecillion
syn keyword     frinkInt    milliard billiard trilliard

syn keyword     frinkInt    vigintillion centillion googol
syn keyword     frinkInt    dozen score

syn keyword     frinkInt    lakh lac crore

syn match       frinkInt    /-\?\<\(\d\|_\)\+\>/
syn match       frinkInt    /-\?\<\d\+ee-\?\d\+\>/
syn match       frinkInt    /-\?\<[0-9a-zA-Z]\+\\\\\d+\>/
syn match       frinkInt    /\<0[xX]\(\x\|_\)\+\>/
syn match       frinkInt    /\<0b\([01]\|_\)\+\>/

syn keyword     frinkBool   true TRUE false FALSE

syn match       frinkFloat  /\<-\?\d*.\d*\([eE]\d\+\)\?\>/

syn match       frinkStringInterp   contained /$[a-zA-Z]\w*\>/
syn match       frinkStringInterp   contained /${\w\{-}}/
syn region      frinkString start=/"/ skip=/\\"/ end=/"/ contains=@frinkStringGroup keepend
syn region      frinkString start=/"""/ end=/"""/ contains=@frinkStringGroup keepend
syn cluster     frinkStringGroup contains=frinkStringInterp

syn match       frinkDate           /#[^#]\+#/
syn match       frinkDateFormat     /###[^#]\+###/
syn match       frinkDateFormat     /####[^#]\+####/

" Comments
syn keyword frinkTodo       contained TODO FIXME XXX
syn cluster frinkCommentGrp contains=frinkTodo

" Operators
syn match   frinkOperatorAssign /=/
syn match   frinkOperatorDecl /:=/
syn match   frinkOperatorShowAs /:->/
syn match   frinkOperatorSep /,/
syn match   frinkOperatorAccess /\./
syn match   frinkOperatorRegexMatch /=\~/
syn match   frinkOperatorIndex /@/

syn match   frinkOperatorBool /&&/
syn match   frinkOperatorBool /||/
syn match   frinkOperatorBool /!/
syn keyword frinkOperatorBool and AND or OR not NOT nand NAND nor NOR xor XOR implies IMPLIES
syn match   frinkOperatorBool /?/
syn match   frinkOperatorBool /:/

syn match   frinkOperatorComp /</
syn match   frinkOperatorComp />/
syn match   frinkOperatorComp /==/
syn match   frinkOperatorComp />=/
syn match   frinkOperatorComp /<=/

syn keyword frinkOperatorIntervalComp CEQ CNE CLT CLE CGT CGE PEQ PNE PLT PLE PGT PGE

syn match   frinkOperatorMath /->/
syn match   frinkOperatorMath /+/
syn match   frinkOperatorMath /-/
syn match   frinkOperatorMath /\*/
syn match   frinkOperatorMath /\//
syn match   frinkOperatorMath /\^/
syn match   frinkOperatorMath /\s%\s/ms=s+1,me=e-1
syn match   frinkOperatorMath /!/
syn match   frinkOperatorMath /<=>/

syn keyword frinkOperatorMath mod div
syn keyword frinkOperatorMath conforms
syn keyword frinkOperatorMath square sq cubic cu squared cubed

syn match   frinkOperatorMath /⁻/

syn cluster frinkOperator contains=frinkOperatorAssign,frinkOperatorDecl,frinkOperatorShowAs,frinkOperatorSep
syn cluster frinkOperator add=frinkOperatorAccess,frinkOperatorBool,frinkOperatorComp,frinkOperatorIntervalComp
syn cluster frinkOperator add=frinkOperatorRegexMatch,frinkOperatorIndex,frinkOperatorMath

" Constants
" TODO: all below can be modified by prefixes, should they be moved to units?
syn keyword     frinkConstant           pi i e c light lightspeed h ℎ hbar ℏ
syn keyword     frinkConstant           au ua astronomicalunit
syn keyword     frinkConstant           G gravitationalconstant
syn keyword     frinkConstant           mu0 magneticconstant permeabilityofvacuum
syn keyword     frinkConstant           epsilon0 permittivityofvacuum electricconstant
syn keyword     frinkConstant           coulombconst k_e
syn keyword     frinkConstant           energy elementarycharge electroncharge protoncharge
syn keyword     frinkConstant           neutroncharge upquarkcharge downquarkcharge

" Keywords
syn keyword     frinkKeywordBuiltinType         array boolean date dict set regexp subst string Unit interval range
syn keyword     frinkKeywordClass               class interface
syn keyword     frinkKeywordVar                 var is class
syn keyword     frinkKeywordMem                 new
syn keyword     frinkKeywordEval                eval unsafeEval

syn keyword     frinkKeywordControl             while do next break
syn keyword     frinkKeywordControl             for to step multifor
syn keyword     frinkKeywordControl             try finally

syn keyword     frinkKeywordCondition           if then else

syn cluster     frinkKeyword contains=frinkKeywordBuiltinType,frinkKeywordClass,frinkKeywordVar,frinkKeywordMem
syn cluster     frinkKeyword add=frinkKeywordEval,frinkKeywordControl
"TODO:
" Builtin types and functions for them
"
" positive negative length -- stdlib functions
"
" makeArray push pop pushAll remove removeLen removeValue removeAll
" removeRandom indexOf lastIndexOf permute lexicographicPermute slice
" sliceLength ...
"
" sort lexicalSort select remove map split join zip
"
" print println input now
"
syn match   frinkLabel          /\v^\s*\w+:/me=e-1

syn region  frinkBlock          start="{" end="}" transparent fold
syn region  frinkParen          start="(" end=")" transparent
syn region  frinkArray          start="\[" end="\]" transparent

" TODO: regex syntax
syn region  frinkRegex          start="%r\/" skip="[^\\]\\/" end="\/(i|g)+" keepend
syn region  frinkRegexSub       start="%r\/" skip="[^\\]\\/" end="\/(i|g|e)+" keepend

syn region  frinkComment        start="\/\*" end="\*\/" contains=@frinkCommentGrp
syn region  frinkComment        start="//" end="$" keepend contains=@frinkCommentGrp

if version >= 508 || !exists("did_frink_syn_inits")
    if version < 508
        let did_frink_syn_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    HiLink frinkConstant                Constant

    HiLink frinkUnit                    Identifier

    HiLink frinkInt                     Number
    HiLink frinkFloat                   Float
    HiLink frinkBool                    Boolean
    HiLink frinkDate                    Number
    HiLink frinkDateFormat              String

    HiLink frinkStringInterp            Identifier
    HiLink frinkString                  String

    HiLink frinkTodo                    Todo
    HiLink frinkComment                 Comment

    HiLink frinkOperatorAssign          Operator
    HiLink frinkOperatorDecl            Operator
    HiLink frinkOperatorShowAs          Operator
    HiLink frinkOperatorSep             Operator
    HiLink frinkOperatorAccess          Operator

    HiLink frinkOperatorMath            Operator
    HiLink frinkOperatorBool            Operator
    HiLink frinkOperatorComp            Operator
    HiLink frinkOperatorIntervalComp    Operator

    HiLink frinkKeywordBuiltinType      Keyword
    HiLink frinkKeywordControl          Keyword
    HiLink frinkKeywordClass            Keyword
    HiLink frinkKeywordVar              Keyword
    HiLink frinkKeywordMem              Keyword
    HiLink frinkKeywordEval             Keyword
    HiLink frinkKeywordCondition        Conditional

    HiLink frinkLabel                   Label

    delcommand HiLink
endif

let b:current_syntax = "frink"
