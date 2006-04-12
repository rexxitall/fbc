''
''
'' attributes -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xslt_attributes_bi__
#define __xslt_attributes_bi__

#include once "libxslt/xsltexports.bi"
#include once "libxml/tree.bi"

declare sub xsltParseStylesheetAttributeSet cdecl alias "xsltParseStylesheetAttributeSet" (byval style as xsltStylesheetPtr, byval cur as xmlNodePtr)
declare sub xsltFreeAttributeSetsHashes cdecl alias "xsltFreeAttributeSetsHashes" (byval style as xsltStylesheetPtr)
declare sub xsltApplyAttributeSet cdecl alias "xsltApplyAttributeSet" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval attributes as zstring ptr)
declare sub xsltResolveStylesheetAttributeSet cdecl alias "xsltResolveStylesheetAttributeSet" (byval style as xsltStylesheetPtr)

#endif
