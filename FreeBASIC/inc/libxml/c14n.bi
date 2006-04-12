''
''
'' c14n -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#define __xml_c14n_bi__
#define __xml_c14n_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/tree.bi"
#include once "libxml/xpath.bi"


declare function xmlC14NDocSaveTo cdecl alias "xmlC14NDocSaveTo" (byval doc as xmlDocPtr, byval nodes as xmlNodeSetPtr, byval exclusive as integer, byval inclusive_ns_prefixes as zstring ptr ptr, byval with_comments as integer, byval buf as xmlOutputBufferPtr) as integer
declare function xmlC14NDocDumpMemory cdecl alias "xmlC14NDocDumpMemory" (byval doc as xmlDocPtr, byval nodes as xmlNodeSetPtr, byval exclusive as integer, byval inclusive_ns_prefixes as zstring ptr ptr, byval with_comments as integer, byval doc_txt_ptr as zstring ptr ptr) as integer
declare function xmlC14NDocSave cdecl alias "xmlC14NDocSave" (byval doc as xmlDocPtr, byval nodes as xmlNodeSetPtr, byval exclusive as integer, byval inclusive_ns_prefixes as zstring ptr ptr, byval with_comments as integer, byval filename as zstring ptr, byval compression as integer) as integer

type xmlC14NIsVisibleCallback as integer ptr

declare function xmlC14NExecute cdecl alias "xmlC14NExecute" (byval doc as xmlDocPtr, byval is_visible_callback as xmlC14NIsVisibleCallback, byval user_data as any ptr, byval exclusive as integer, byval inclusive_ns_prefixes as zstring ptr ptr, byval with_comments as integer, byval buf as xmlOutputBufferPtr) as integer

#endif
