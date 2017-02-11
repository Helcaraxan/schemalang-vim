" Vim syntax file
" Language: schemalang for SpatialOS by Improbable(tm)
" Maintainer: Duco van Amstel <Helcaraxan @ GitHub>
" Last Change: 11.02.2017
" Version: 0.1.0

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

"-------------------------------------------------------------------------------
" Syntax
"-------------------------------------------------------------------------------

" todo
syntax keyword schemaTodo TODO FIXME XXX NOTE contained

" comments
syntax match schemaComment "//.*$" contains=schemaTodo
syntax match schemaComment "/\*\(\(\_.*\*/\)\|\(\_.*\(\*/\)\@!\_.*\%$\)\)" contains=schemaTodo


" package
syntax match schemaPackageName "\l\+\(\.\l\+\)*\(;\)\@=" display
syntax keyword schemaPackageKeyword package nextgroup=schemaPackageName skipwhite


" field ID
syntax match schemaFieldId "=\s\+[1-9][0-9]*\(;\)\@=" contained display


" identifiers
syntax match schemaFieldName "\l\([a-z_]*\l\)\?" contained nextgroup=schemaFieldId skipwhite


" type name
syntax match schemaUserTypeName "\(\u\l\+\)\+\u\?" contained nextgroup=schemaFieldName skipwhite


" type tokens
syntax keyword schemaTypeKeywords bool contained nextgroup=schemaFieldName skipwhite
syntax keyword schemaTypeKeywords uint32 uint64 int32 int64 sint32 sint64 contained nextgroup=schemaFieldName skipwhite
syntax keyword schemaTypeKeywords fixed32 fixed64 sfixed32 sfixed64 float double contained nextgroup=schemaFieldName skipwhite
syntax keyword schemaTypeKeywords string bytes contained nextgroup=schemaFieldName skipwhite
syntax keyword schemaTypeKeywords Coordinates Vector3d Vector3f contained nextgroup=schemaFieldName skipwhite
syntax keyword schemaTypeKeywords EntityId EntityPosition contained nextgroup=schemaFieldName skipwhite


" container types
syntax region schemaContainedType start="<" end=">" contained contains=schemaUserTypeName,schemaTypeKeywords nextgroup=schemaFieldName skipwhite
syntax keyword schemaContainerKeywords list map option contained nextgroup=schemaContainedType


" component ID
syntax match schemaComponentId "^\s*id\s\+=\s\+[1-9][0-9]*\(;\)\@=" contained display


" block definitions
syntax keyword schemaBlockKeywords component enum type nextgroup=schemaUserTypeName skipwhite
syntax region schemaBlockStatement start="." end=";\|}" contained display oneline transparent contains=ALLBUT,schemaPackageKeyword,schemaPackageName nextgroup=schemaBlockStatement
syntax region schemaBlockBody start="{" end="}" fold transparent contains=ALLBUT,schemaPackage.*,schemaFieldName,schemaFieldId


" highlighting groups
highlight link schemaTodo              Todo

highlight link schemaComment           Comment

highlight link schemaPackageKeyword    Keyword
highlight link schemaPackageName       Identifier

highlight link schemaBlockKeywords     Keyword

highlight link schemaComponentId       Constant

highlight link schemaContainerKeywords Structure
highlight link schemaUserTypeName      Type
highlight link schemaTypeKeywords      Type

highlight link schemaFieldName         Identifier
highlight link schemaFieldId           Tag


"-------------------------------------------------------------------------------
" /Syntax
"-------------------------------------------------------------------------------

" Activate the syntax highlighting
let b:current_syntax = "schema"
