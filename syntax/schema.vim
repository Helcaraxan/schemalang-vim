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


" constants
syntax match    schemaConstantEmpty "_" contained display
syntax keyword  schemaConstantBool true false contained
syntax match    schemaConstantInt "[0-9]\+" contained display
syntax match    schemaConstantFloat "[0-9]\+\.[0-9]\+" contained display
syntax region   schemaConstantString start="\"" end="\"" contained display

syntax cluster  schemaConstant contains=schemaConstantEmpty,schemaConstantEnum,schemaConstantBool,schemaConstantInt,schemaConstantFloat,schemaConstantString


" package
syntax region   schemaPackage start="package" end=";" oneline contains=schemaPackageKeyword,schemaPackageName display
syntax keyword  schemaPackageKeyword package contained nextgroup=schemaPackageName skipwhite
syntax match    schemaPackageName "[a-z]\+\([a-z_]*[a-z]\)\=\(\.[a-z]\+\([a-z_]*[a-z]\)\=\)*" contained contains=NONE display


" basic types
syntax keyword  schemaTypeKeywords bool contained
syntax keyword  schemaTypeKeywords uint32 uint64 int32 int64 sint32 sint64 contained
syntax keyword  schemaTypeKeywords fixed32 fixed64 sfixed32 sfixed64 float double contained
syntax keyword  schemaTypeKeywords string bytes contained
syntax keyword  schemaTypeKeywords Coordinates Vector3d Vector3f contained
syntax keyword  schemaTypeKeywords EntityId EntityPosition contained


" user-defined types
syntax match    schemaTypeUser "\([a-z]\+\([a-z_]*[a-z]\)\=\(\.[a-z]\+\([a-z_]*[a-z]\)\=\)*\.\)\=[A-Z][a-zA-Z0-9]*" contained contains=SchemaPackageName,SchemaTypeUserName display
syntax match    schemaTypeUserName "[A-Z][a-zA-Z0-9]*" contained contains=NONE skipwhite display


" collection types
syntax region   schemaTypeCollectionDef start="\(transient\s\+\)\=\(list\|map\|option\)" end=">" contained oneline contains=schemaCollectionTransient,schemaCollection
syntax keyword  schemaTypeCollectionTransient transient contained nextgroup=schemaTypeCollection skipwhite
syntax region   schemaTypeCollection start="\(list\|map\|option\)<" end=">" skip="\A\(list\|map\|option\)<.\{-}>" contained oneline contains=schemaTypeCollection,@schemaTypes
syntax keyword  schemaTypeCollectionKeywords list map option contained nextgroup=schemaTypeCollectionContainer skipwhite


" types alias cluster
syntax cluster schemaTypes contains=schemaTypeKeywords,schemaTypeUser,schemaTypeCollection


" component block
syntax region   schemaBlockComponent start="component" end="}" fold keepend contains=schemaBlockComponent,schemaBlockComponentKeyword,schemaStatement,schemaTypeUserName,schemaAnnotation,schemaComment
syntax keyword  schemaBlockComponentKeyword component contained nextgroup=schemaTypeUserName skipwhite


" enum block
syntax region   schemaBlockEnum start="enum" end="}" fold keepend contains=schemaBlockEnumKeyword,schemaTypeUserName,schemaBlockEnumStatement,schemaAnnotation,schemaComment
syntax keyword  schemaBlockEnumKeyword enum contained nextgroup=schemaTypeUserName skipwhite


" type block
syntax region   schemaBlockType start="type" end="}" skip="\stype\s.\{-}}" fold keepend contains=schemaBlockType,schemaBlockTypeKeyword,schemaAnnotation,schemaStatement,schemaTypeUserName,schemaComment
syntax keyword  schemaBlockTypeKeyword type contained nextgroup=schemaTypeUserName skipwhite


" annotation block
syntax region   schemaAnnotation start="\[" end="\]" oneline contains=schemaTypeUser,schemaAnnotationInit display
syntax region   schemaAnnotationInit start="(" end=")" skip=".(.\{-})" contained oneline contains=schemaStatementFieldName,@schemaConstant,schemaTypeUser,schemAnnotationInit

"
" statements
syntax region   schemaStatement start="\a" end=";" keepend contained oneline contains=schemaTransientKeyword,schemaStatementCommand,schemaStatementComponentId,schemaStatementData,schemaStatementEvent,@schemaTypes,schemaStatementFieldName,schemaStatementFieldId display


" fields
syntax match    schemaStatementFieldName "[a-z]\([a-z_]*[a-z]\)\=" contained display
syntax match    schemaStatementFieldId "\(0\|[1-9][0-9]*\);\@=" contained display


" data component
syntax region   schemaStatementData start="data" end=";" keepend oneline contained contains=schemaStatementDataKeyword,@schemaTypes display
syntax keyword  schemaStatementDataKeyword data contained nextgroup=schemaTypeKeywords,schemaTypeUser skipwhite


" events
syntax match    schemaStatementEvent "event\s\+\S\+\s\+\S\+;" contained contains=schemaStatementEventKeyword,schemaStatementEventName,@schemaTypes display
syntax keyword  schemaStatementEventKeyword event contained nextgroup=@schemaTypes skipwhite
syntax match    schemaStatementEventName "[a-z]\([a-z_]*[a-z]\)\=;\@=" contained contains=schemaStatementFieldName display


" commands
syntax region   schemaStatementCommand start="command" end=";" contained oneline contains=schemaStatementCommandKeyword,@schemaTypes,schemaStatementFieldName,schemaStatementCommandOutput display
syntax keyword  schemaStatementCommandKeyword command contained nextgroup=schemaStatementCommandOutput skipwhite
syntax region   schemaStatementCommandInput start="(" end=")" contained contains=@schemaTypes display


" enums
syntax region   schemaBlockEnumStatement start="\a" end=";" keepend contained oneline contains=schemaBlockEnumField,schemaStatementFieldId display
syntax match    schemaBlockEnumField "\u\+" contained contains=NONE nextgroup=schemaStatementFieldId skipwhite display


" component ID (at bottom to take priority over earlier defined & wider matches)
syntax match    schemaStatementComponentId "id\s*=\s*[1-9][0-9]*;\@=" contained contains=NONE display


" comments (at bottom to take priority over earlier defined & wider matches)
syntax match    schemaComment "//.*$" contains=schemaTodo display
syntax match    schemaComment "/\*\(\(\_.*\*/\)\|\(\_.*\(\*/\)\@!\_.*\%$\)\)" contains=schemaTodo


"-------------------------------------------------------------------------------
" Highlight configuration
"-------------------------------------------------------------------------------

""" highlighting groups
highlight link schemaTodo                           Todo

highlight link schemaComment                        Comment

highlight link schemaConstantEmpty                  Constant
highlight link schemaConstantBool                   Constant
highlight link schemaConstantInt                    Constant
highlight link schemaConstantFloat                  Constant
highlight link schemaConstantString                 Constant

highlight link schemaPackageKeyword                 Keyword
highlight link schemaPackageName                    Identifier

highlight link schemaTypeKeywords                   Type
highlight link schemaTypeUserName                   Type

highlight link schemaBlockComponentKeyword          Keyword
highlight link schemaBlockEnumKeyword               Keyword
highlight link schemaBlockTypeKeyword               Keyword

highlight link schemaBlockEnumField                 Identifier

highlight link schemaTypeCollectionTransient        Keyword
highlight link schemaTypeCollectionKeywords         Keyword

highlight link schemaStatementFieldId               Constant

highlight link schemaStatementComponentId           Constant

highlight link schemaStatementFieldName             Identifier

highlight link schemaStatementDataKeyword           Keyword
highlight link schemaStatementEventKeyword          Keyword
highlight link schemaStatementCommandKeyword        Keyword


"-------------------------------------------------------------------------------
" Post-setup processing
"-------------------------------------------------------------------------------

" Activate the syntax highlighting
let b:current_syntax = "schema"
