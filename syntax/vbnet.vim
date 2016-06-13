" Vim syntax file
" Language   : VisualBasic.NET
" Author     : OGURA Daiki
" Maintainers: Eivy <modern.times.rock.and.roll+git@gmail.com>

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

syn case match

syn keyword vbnetStatement Auto Ansi Assembly Declare Lib
syn keyword vbnetStatement Continue Custom
syn keyword vbnetStatement Default
syn keyword vbnetStatement Dim As Redim ReDim
syn keyword vbnetStatement Event Error
syn keyword vbnetStatement Goto GoSub
syn keyword vbnetStatement RaiseEvent
syn keyword vbnetStatement Step Stop
syn keyword vbnetStatement SyncLock
syn keyword vbnetStatement TypeOf
syn keyword vbnetStatement Unicode Variant
syn keyword vbnetStatement When Do Until Loop Resume Erase Preserve IIF

syn keyword vbnetTypes Boolean Byte Char Date Decimal Double
syn keyword vbnetTypes Integer Long Object Short Single String
syn keyword vbnetTypes UInteger ULong UShort SByte
syn keyword vbnetTypes List Dictionary IEnumerable IObservable Func Action

syn match vbnetOperator "[()+\-/*=&]"
syn match vbnetOperator "[<>]=\="
syn match vbnetOperator "<>"
syn match vbnetOperator "\s\+_$"
syn keyword vbnetOperator New And Or AndAlso OrElse Is Not IsNot Like Mod

syn keyword vbnetStorage Delegate Namespace
syn keyword vbnetTypeDef Class Interface
syn match vbnetTypeDefEnd "^\s*\<End\> \%(Class\|Interface\|Namespace\)"

syn keyword vbnetStructure Structure Enum Module
syn match vbnetStructureEnd "^\s*\<End\> \%(Structure\|Enum\|Module\)"

syn keyword vbnetRepeat For Each Return While Next To
syn keyword vbnetConditional If Then Else ElseIf Case
syn match vbnetConditional "^\s*Select Case"
syn match vbnetConditionalEnd "^\s*\<End\> \%(If\|Select\)"

syn keyword vbnetModifier Inherits Implements MustInherit MustOverride Const Overrides Overridable Overloads Readonly WriteOnly Shared NotInheritable NotOverridable Shadows
syn keyword vbnetFunction Sub Function Operator
syn match vbnetFunction "^\s*\<End\> \%(Function\|Sub\)"
syn keyword vbnetFunction CBool CByte CChar CDate CDbl CDec CInt CLng CObj CSByte CShort CSng CStr CUInt CULng CUShort Asc AscW Chr ChrW Format Hex Str Val

syn keyword vbnetScopeDecl Private Protected Public Friend

syn keyword vbnetSpecial Call Of
syn keyword vbnetSugar AddHandler AddressOf Alias WithEvents RemoveHandler Handles From
syn match vbnetDefAnonymousTypedef "=\s\<New\> \%(With$\|With\s*{$\)"

syn keyword vbnetProperty Property Get Set
syn match vbnetPropertyEnd "^\s*End \%(Get\|Set\|Property\)$"

syn keyword vbnetKeyword ByVal ByRef GetType ParamArray Off On Option Optional Exit Imports
syn keyword vbnetException Try Catch Finally Throw
syn match vbnetException "\<End\> Try$"
syn match vbnetUsing "Using"
syn match vbnetUsing "\<End\> Using$"
syn keyword vbnetBoolean True False
syn match vbnetDelimiter ":\|\s_$"

syn keyword vbnetConst MyBase MyClass Me Nothing

syn keyword vbnetTodo contained TODO

"integer number, or floating point number without a dot.
syn match vbnetNumber "\<\d\+\>"
"floating point number, with dot
syn match vbnetNumber "\<\d\+\.\d*\>"
"floating point number, starting with a dot
syn match vbnetNumber "\.\d\+\>"

"String and Character contstants
syn match vbnetchar "\"[0-9A-Za-z_]\"c"
syn region vbnetString start=+"+ end=+"+

syn region vbnetComment start="\<REM\>" end="$" contains=vbnetTodo
syn region vbnetComment start="'" end="$" contains=vbnetTodo

syn match vbnetPreCondit "^\s*\zs#If\s.*Then"
syn match vbnetPreCondit "^\s*\zs#Else\(If\s\+.*Then\)\?"
syn match vbnetPreCondit "#End If"

syn region vbnetPreCondit start="#Region\s\+" end="$" transparent contains=TOP
syn match vbnetPreCondit "#End Region"

syn region vbnetPreCondit start="^#ExternalSource(" end=")$" transparent contains=TOP
syn match vbnetPreCondit "^#End ExternalSource$"

syn region vbnetPreCondit start="^\s*#Const\s" end="$"

syn region vbnetLineNumber start="^\d" end="\s"

syn match vbnetTypeSpecifier "[a-zA-Z0-9][\$%&!#]"ms=s+1

syn keyword vbnetWith With
syn match vbnetWith 'End\s\+With'

" xml markup inside "'''" comments
syn cluster xmlRegionHook add=vbXmlCommentLeader
syn cluster xmlCdataHook add=vbXmlCommentLeader
syn cluster xmlStartTagHook add=vbXmlCommentLeader
syn keyword vbXmlTag contained Libraries Packages Types Excluded ExcludedTypeName ExcludedLibraryName
syn keyword vbXmlTag contained ExcludedBucketName TypeExcluded Type TypeKind TypeSignature AssemblyInfo
syn keyword vbXmlTag contained AssemblyName AssemblyPublicKey AssemblyVersion AssemblyCulture Base
syn keyword vbXmlTag contained BaseTypeName Interfaces Interface InterfaceName Attributes Attribute
syn keyword vbXmlTag contained AttributeName Members Member MemberSignature MemberType MemberValue
syn keyword vbXmlTag contained ReturnValue ReturnType Parameters Parameter MemberOfPackage
syn keyword vbXmlTag contained ThreadingSafetyStatement Docs devdoc example overload remarks returns summary
syn keyword vbXmlTag contained threadsafe value internalonly nodoc exception param permission platnote
syn keyword vbXmlTag contained seealso b c i pre sub sup block code note paramref see subscript superscript
syn keyword vbXmlTag contained list listheader item term description altcompliant altmember

syn cluster xmlTagHook add=vbXmlTag

syn match vbXmlCommentLeader +'''+ contained
syn match vbXmlComment +'''.*$+ contains=vbXmlCommentLeader,@vbXml,@Spell
syntax include @vbXml syntax/xml.vim
hi def link xmlRegion Comment

syn region vbnetAttribute start="^\s*<[a-zA-Z]" end=">" contains=vbnetString

syn region    vbnetRegion matchgroup=vbnetPreCondit start="^\s*#\s*Region.*$"
    \ end="^\s*#\s*End\s*Region" transparent fold contains=TOP

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_vbnet")
    let did_vbnet_syntax_inits = 1

    hi link vbnetLineNumber Comment
    hi link vbnetNumber Number
    hi link vbnetConst Constant
    hi link vbnetBoolean Boolean
    hi link vbnetRepeat Repeat
    hi link vbnetConditional Conditional
    hi link vbnetConditionalEnd Conditional
    hi link vbnetKeyword Keyword
    hi link vbnetException Exception
    hi link vbnetUsing Exception
    hi link vbnetWith Exception
    hi link vbnetAttribute PreProc
    hi link vbnetStorage StorageClass
    hi link vbnetModifier vbnetStorage
    hi link vbnetScopeDecl vbnetStorage
    hi link vbnetTypeDef TypeDef
    hi link vbnetTypeDefEnd TypeDef
    hi link vbnetStructure Structure
    hi link vbnetStructureEnd Structure
    hi link vbnetError Error
    hi link vbnetStatement Statement
    hi link vbnetString String
    hi link vbnetchar vbnetString
    hi link vbnetComment Comment
    hi link vbnetTodo Todo
    hi link vbnetFunction Function
    hi link vbnetMethods PreProc
    hi link vbnetPreCondit PreCondit
    hi link vbnetSpecial Special
    hi link vbnetSugar vbnetSpecial
    hi link vbnetDefAnonymousTypedef vbnetSpecial
    hi link vbnetProperty vbnetSugar
    hi link vbnetPropertyEnd vbnetSugar
    hi link vbnetTypeSpecifier Type
    hi link vbnetTypes Type
    hi link vbnetOperator Operator
    hi link vbnetDelimiter Delimiter

    " xml markup
    hi def link vbXmlCommentLeader Comment
    hi def link vbXmlComment Comment
    hi def link vbXmlTag Statement

endif

let b:current_syntax = "vbnet"
