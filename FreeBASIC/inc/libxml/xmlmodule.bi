''
''
'' xmlmodule -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#define __xml_xmlmodule_bi__
#define __xml_xmlmodule_bi__

#include once "libxml/xmlversion.bi"

type xmlModule as _xmlModule
type xmlModulePtr as xmlModule ptr

enum xmlModuleOption
	XML_MODULE_LAZY = 1
	XML_MODULE_LOCAL = 2
end enum


declare function xmlModuleOpen cdecl alias "xmlModuleOpen" (byval filename as zstring ptr, byval options as integer) as xmlModulePtr
declare function xmlModuleSymbol cdecl alias "xmlModuleSymbol" (byval module as xmlModulePtr, byval name as zstring ptr, byval result as any ptr ptr) as integer
declare function xmlModuleClose cdecl alias "xmlModuleClose" (byval module as xmlModulePtr) as integer
declare function xmlModuleFree cdecl alias "xmlModuleFree" (byval module as xmlModulePtr) as integer

#endif
