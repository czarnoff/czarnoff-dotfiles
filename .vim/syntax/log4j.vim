"Vim syntax file
" Language: Celestia Star Catalogs
" Maintainer: Kevin Lauder
" Latest Revision: 26 April 2008
"
 if exists("b:current_syntax")
   finish
 endif

 syn keyword log4jInfoLevel DEBUG INFO TRACE 
 syn keyword log4jErrorLevel FATAL WARN
 syn region log4jError start='\[ERROR' end='\d\{4}-\d\{2}-\d\{2}' keepend
 syn match logDate '\d\{4}-\d\{2}-\d\{2}'
 syn match logDate '\d\{2}:\d\{2}:\d\{2},\d\{3}'

 hi def link log4jInfoLevel Comment
 hi def link log4jErrorLevel Todo
 hi def link logDate Comment
 hi def link log4jError Error
