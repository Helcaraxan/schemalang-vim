" Vim syntax file
" Language: schemalang for SpatialOS by Improbable(tm)
" Maintainer: Duco van Amstel <Helcaraxan @ GitHub>
" Last Change: 09.04.2017
" Version: 0.1.4

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

"-------------------------------------------------------------------------------
" Syntax
"-------------------------------------------------------------------------------

" todo
syntax keyword  schemaTodo TODO FIXME XXX NOTE contained


" comments
syntax match    schemaComment "//.*$" contains=schemaTodo
syntax match    schemaComment "/\*\(\(\_.*\*/\)\|\(\_.*\(\*/\)\@!\_.*\%$\)\)" contains=schemaTodo


" package
syntax region   schemaPackage start="package" end=";" oneline contains=schemaPackageKeyword,schemaPackageName display
syntax keyword  schemaPackageKeyword package nextgroup=schemaPackageName skipwhite
syntax match    schemaPackageName "\l\+\(\.\l\+\)*" display


" basic types
syntax keyword  schemaTypeKeywords bool contained nextgroup=schemaField skipwhite
syntax keyword  schemaTypeKeywords uint32 uint64 int32 int64 sint32 sint64 contained nextgroup=schemaField skipwhite
syntax keyword  schemaTypeKeywords fixed32 fixed64 sfixed32 sfixed64 float double contained nextgroup=schemaField skipwhite
syntax keyword  schemaTypeKeywords string bytes contained nextgroup=schemaField skipwhite
syntax keyword  schemaTypeKeywords Coordinates Vector3d Vector3f contained nextgroup=schemaField skipwhite
syntax keyword  schemaTypeKeywords EntityId EntityPosition contained nextgroup=schemaField skipwhite


" user-defined types
syntax match    schemaTypeUser "\(\l\+\.\)*\u\a*\(\.\u\a*\)*" contained contains=schemaPackageName,schemaTypeUserName skipwhite
syntax match    schemaTypeUserName "\u\a*\(\.\u\a*\)*" contained skipwhite


" collection types
syntax match    schemaTypeCollection "list\|map\S\+>\s" contained contains=schemaTypeCollectionContainer,schemaTypeCollectionKeywords skipwhite
syntax keyword  schemaTypeCollectionKeywords list map contained nextgroup=schemaTypeCollectionContainer
syntax region   schemaTypeCollectionContainer start="<" end=">" contained contains=schemaTypeCollection,schemaTypeKeywords,schemaTypeUser skipwhite


" component block
syntax region   schemaBlockComponent start="component" end="^}" keepend contains=schemaBlockComponent,schemaBlockComponentKeyword,schemaStatement,schemaTypeUserName,schemaComment display
syntax keyword  schemaBlockComponentKeyword component contained nextgroup=schemaTypeUserName skipwhite


" enum block
syntax region   schemaBlockEnum start="enum" end="^}" keepend contains=schemaBlockEnumField,schemaBlockEnumKeyword,schemaBlockEnumStatement,schemaTypeUserName,schemaComment display
syntax keyword  schemaBlockEnumKeyword enum contained nextgroup=schemaTypeUserName skipwhite
syntax region   schemaBlockEnumStatement start="\a" end=";" contained oneline contains=schemaBlockEnumField,schemaFieldId nextgroup=schemaBlockEnumStatement,schemaComment display
syntax match    schemaBlockEnumField "\a\+" contained nextgroup=schemaFieldId display


" type block
syntax region   schemaBlockType start="type \u\a* {" end="^}" keepend contains=schemaBlockType,schemaBlockTypeKeyword,schemaStatement,schemaTypeUserName,schemaComment display
syntax keyword  schemaBlockTypeKeyword type contained nextgroup=schemaTypeUserName skipwhite


" statements
syntax region   schemaStatement start="\a" end=";" contained oneline contains=schemaStatementCommand,schemaStatementComponentId,schemaStatementData,schemaStatementEvent,schemaStatementField,schemaStatementOption nextgroup=schemaStatement display


" component ID
syntax match    schemaStatementComponentId "id\s\+=\s\+[1-9][0-9]*\(;\)\@=" contained display


" fields
syntax match    schemaStatementField "\S\+\s\+\S\+\s\+=\s\+\S;" contained contains=schemaStatementFieldName,schemaStatementFieldId,schemaTypeCollection,schemaTypeKeywords,schemaTypeUser display
syntax match    schemaStatementFieldName "\l\+\(_\l\+\)*\(\s\+=\)\@=" contained nextgroup=schemaStatementFieldId skipwhite
syntax match    schemaStatementFieldId "\(=\s\+\)\@<=[1-9][0-9]*\(;\)\@=" contained display


" data component
syntax match    schemaStatementData "data\s\+\S\+;" contained contains=schemaStatementDataKeyword,schemaTypeCollection,schemaTypeKeywords,schemaTypeUser display
syntax keyword  schemaStatementDataKeyword data contained nextgroup=schemaTypeKeywords,schemaTypeUser skipwhite


" options
syntax region   schemaStatementOption start="option" end=";" contained contains=schemaStatementOptionKeywords,schemaStatementOptionType,schemaStatementOptionValue display
syntax keyword  schemaStatementOptionKeyword option contained nextgroup=schemaStatementOptionType skipwhite
syntax keyword  schemaStatementOptionType queryable synchronized contained nextgroup=schemaStatementOptionValue skipwhite
syntax keyword  schemaStatementOptionValue true false contained


" events
syntax match    schemaStatementEvent "event\s\+\S\+\s\+\S\+;" contained contains=schemaStatementEventKeyword,schemaStatementEventName,schemaTypeCollection,schemaTypeKeywords,schemaTypeUser display
syntax keyword  schemaStatementEventKeyword event contained nextgroup=schemaTypeCollection,schemaTypeKeywords,schemaTypeUser skipwhite
syntax match    schemaStatementEventName "\l\+\(_\l\+\)*\(;\)\@=" contained display


" commands
syntax region   schemaStatementCommand start="command" end=";" contained contains=schemaStatementCommandInput,schemaStatementCommandKeyword,schemaStatementCommandName,schemaStatementCommandOutput display
syntax keyword  schemaStatementCommandKeyword command contained nextgroup=schemaStatementCommandOutput skipwhite
syntax match    schemaStatementCommandOutput "\u\S*\s" contained contains=schemaTypeCollection,schemaTypeKeywords,schemaTypeUser nextgroup=schemaStatementCommandName skipwhite
syntax match    schemaStatementCommandName "\l\+\(_\l\+\)*\((\)\@=" contained nextgroup=schemaStatementCommandInput display
syntax region   schemaStatementCommandInput start="(" end=")" contained contains=schemaTypeCollection,schemaTypeKeywords,schemaTypeUser skipwhite


"-------------------------------------------------------------------------------
" Highlight configuration
"-------------------------------------------------------------------------------

""" highlighting groups
highlight link schemaTodo                       Todo

highlight link schemaComment                    Comment

highlight link schemaPackageKeyword             Keyword
highlight link schemaPackageName                Identifier

highlight link schemaTypeUserName               Type

highlight link schemaTypeKeywords               Type

highlight link schemaTypeCollectionKeywords     Type

highlight link schemaBlockComponentKeyword      Keyword

highlight link schemaBlockEnumKeyword           Keyword
highlight link schemaBlockEnumField             Identifier

highlight link schemaBlockTypeKeyword           Keyword

highlight link schemaStatementFieldId           Constant

highlight link schemaStatementComponentId       Constant

highlight link schemaStatementFieldName         Identifier

highlight link schemaStatementDataKeyword       Keyword

highlight link schemaStatementOptionKeyword     Keyword
highlight link schemaStatementOptionType        Structure
highlight link schemaStatementOptionValue       Constant

highlight link schemaStatementEventKeyword      Keyword
highlight link schemaStatementEventName         Identifier

highlight link schemaStatementCommandKeyword    Keyword
highlight link schemaStatementCommandName       Identifier


"-------------------------------------------------------------------------------
" Post-setup processing
"-------------------------------------------------------------------------------

" Activate the syntax highlighting
let b:current_syntax = "schema"
