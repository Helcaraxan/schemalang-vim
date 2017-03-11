" Vim syntax file
" Language: schemalang for SpatialOS by Improbable(tm)
" Maintainer: Duco van Amstel <Helcaraxan @ GitHub>
" Last Change: 12.02.2017
" Version: 0.1.1

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

"-------------------------------------------------------------------------------
" Syntax
"-------------------------------------------------------------------------------

" package
syntax match schemaPackageName "\(package\s\+\)\@<=\l\+\(\.\l\+\)*\(;\)\@=" display
syntax keyword schemaPackageKeyword package skipwhite

" field
syntax match schemaFieldId "\(=\s\+\)\@<=[1-9][0-9]*\(;\)\@=" contained display
syntax match schemaFieldName "\s\@<=\l\([a-z_]*\l\)\?\(\s\+=\)\@=" contained nextgroup=schemaFieldId skipwhite
syntax region schemaField start="\l" end=";" contained display contains=schemaFieldName,schemaFieldId


" type name
syntax match schemaUserTypeName "\(\s\|(\|<\)\@<=\(\u\l\+\)\+\u\?\(\s\|)\|>\|;\)\@=" display
syntax keyword schemaUserTypeKeyword component enum type nextgroup=schemaUserTypeName skipwhite


" type tokens
syntax keyword schemaTypeKeywords bool contained nextgroup=schemaField skipwhite
syntax keyword schemaTypeKeywords uint32 uint64 int32 int64 sint32 sint64 contained nextgroup=schemaField skipwhite
syntax keyword schemaTypeKeywords fixed32 fixed64 sfixed32 sfixed64 float double contained nextgroup=schemaField skipwhite
syntax keyword schemaTypeKeywords string bytes contained nextgroup=schemaField skipwhite
syntax keyword schemaTypeKeywords Coordinates Vector3d Vector3f contained nextgroup=schemaField skipwhite
syntax keyword schemaTypeKeywords EntityId EntityPosition contained nextgroup=schemaField skipwhite


" container types
syntax region schemaContainedType start="<" end=">" contained contains=schemaUserTypeName,schemaTypeKeywords nextgroup=schemaField skipwhite
syntax keyword schemaContainerKeywords list map contained nextgroup=schemaContainedType


" options
syntax keyword schemaOptionValue true false contained
syntax keyword schemaOptionType queryable synchronized contained nextgroup=schemaOptionValue skipwhite
syntax keyword schemaOptionKeywords option contained nextgroup=schemaOptionType skipwhite


" events
syntax match schemaEventName "\(\s\)\@<=\l\([a-z_]*\l\)\?\(;\)\@=" contained display
syntax match schemaEventType "\(\s\)\@<=\(\l\+\d{0,2}\|\(\u\l\+\)\+\u\?\)\(\s\)\@=" contained contains=schemaUserTypeName,schemaTypeKeywords nextgroup=schemaEventName skipwhite
syntax region schemaEventField start="\l\|\u" end=";" contained display contains=schemaEventType,schemaEventName
syntax keyword schemaEventKeywords event contained nextgroup=schemaEventField skipwhite


" commands
syntax region schemaCommandInputType start="(" end=")" contained contains=schemaUserTypeName,schemaTypeKeywords
syntax match schemaCommandName "\(\s\)\@<=\l\([a-z_]*\l\)\?\((\)\@=" contained display nextgroup=schemaCommandInputType
syntax match schemaCommandOutputType "\(\s\)\@<=\(\l\+\d{0,2}\|\(\u\l\+\)\+\u\?\)\(\s\)\@=" contained contains=schemaUserTypeName,schemaTypeKeywords nextgroup=schemaCommandName skipwhite
syntax region schemaCommandField start="\l\|\u" end=";" contained display contains=schemaCommandOutputType,schemaCommandName,schemaCommandInputType
syntax keyword schemaCommandKeywords command contained nextgroup=schemaCommandField skipwhite


" data
syntax match schemaDataType "\(\s\)\@<=\(\l\+\d{0,2}\|\(\u\l\+\)\+\u\?\)\(;\)\@=" contained contains=schemaUserTypeName,schemaTypeKeywords
syntax region schemaDataField start="\l\|\u" end=";" contained display contains=schemaDataType
syntax keyword schemaDataKeywords data contained nextgroup=schemaDataField skipwhite


" component ID
syntax match schemaComponentId "^\s*id\s\+=\s\+[1-9][0-9]*\(;\)\@=" contained display


" block definitions
syntax region schemaBlockStatement start="." end=";\|}" contained display oneline transparent contains=ALLBUT,schemaPackage.* nextgroup=schemaBlockStatement
syntax region schemaBlockBody start="{" end="}" fold transparent contains=ALLBUT,schemaPackage.*


" todo
syntax keyword schemaTodo TODO FIXME XXX NOTE contained


" comments
syntax match schemaComment "//.*$" contains=schemaTodo
syntax match schemaComment "/\*\(\(\_.*\*/\)\|\(\_.*\(\*/\)\@!\_.*\%$\)\)" contains=schemaTodo


"-------------------------------------------------------------------------------
" Highlight configuration
"-------------------------------------------------------------------------------

" highlighting groups
highlight link schemaTodo              Todo

highlight link schemaComment           Comment

highlight link schemaPackageKeyword    Keyword
highlight link schemaPackageName       Identifier

highlight link schemaComponentId       Constant

highlight link schemaContainerKeywords Structure

highlight link schemaOptionKeywords    Keyword
highlight link schemaOptionType        Structure
highlight link schemaOptionValue       Constant

highlight link schemaEventKeywords     Structure
highlight link schemaEventName         Identifier

highlight link schemaCommandKeywords   Structure
highlight link schemaCommandName       Identifier

highlight link schemaDataKeywords      Structure

highlight link schemaUserTypeName      Type
highlight link schemaUserTypeKeyword   Keyword

highlight link schemaTypeKeywords      Type

highlight link schemaFieldName         Identifier
highlight link schemaFieldId           Constant



"-------------------------------------------------------------------------------
" Post-setup processing
"-------------------------------------------------------------------------------

" Activate the syntax highlighting
let b:current_syntax = "schema"
