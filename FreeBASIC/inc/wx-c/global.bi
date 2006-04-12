''
''
'' global -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_global_bi__
#define __wxc_global_bi__

#include once "wx-c/wx.bi"



declare function wxGlobal_GetNumberFromUser cdecl alias "wxGlobal_GetNumberFromUser" (byval msg as zstring ptr, byval prompt as zstring ptr, byval caption as zstring ptr, byval value as integer, byval min as integer, byval max as integer, byval parent as wxWindow ptr, byval pos as wxPoint ptr) as integer
declare function wxGlobal_GetHomeDir cdecl alias "wxGlobal_GetHomeDir" () as wxString ptr
declare function wxGlobal_FileSelector cdecl alias "wxGlobal_FileSelector" (byval message as zstring ptr, byval default_path as zstring ptr, byval default_filename as zstring ptr, byval default_extension as zstring ptr, byval wildcard as zstring ptr, byval flags as integer, byval parent as wxWindow ptr, byval x as integer, byval y as integer) as wxString ptr

declare function wxArrayInt cdecl alias "wxArrayInt_ctor" () as wxArrayInt ptr
declare sub wxArrayInt_dtor cdecl alias "wxArrayInt_dtor" (byval self as wxArrayInt ptr)
declare sub wxArrayInt_RegisterDisposable cdecl alias "wxArrayInt_RegisterDisposable" (byval self as _ArrayInt ptr, byval onDispose as Virtual_Dispose)
declare sub wxArrayInt_Add cdecl alias "wxArrayInt_Add" (byval self as wxArrayInt ptr, byval toadd as integer)
declare function wxArrayInt_Item cdecl alias "wxArrayInt_Item" (byval self as wxArrayInt ptr, byval num as integer) as integer
declare function wxArrayInt_GetCount cdecl alias "wxArrayInt_GetCount" (byval self as wxArrayInt ptr) as integer

declare function wxArrayString cdecl alias "wxArrayString_ctor" () as wxArrayString ptr
declare sub wxArrayString_dtor cdecl alias "wxArrayString_dtor" (byval self as wxArrayString ptr)
declare sub wxArrayString_RegisterDisposable cdecl alias "wxArrayString_RegisterDisposable" (byval self as _ArrayString ptr, byval onDispose as Virtual_Dispose)
declare sub wxArrayString_Add cdecl alias "wxArrayString_Add" (byval self as wxArrayString ptr, byval toadd as zstring ptr)
declare function wxArrayString_Item cdecl alias "wxArrayString_Item" (byval self as wxArrayString ptr, byval num as integer) as wxString ptr
declare function wxArrayString_GetCount cdecl alias "wxArrayString_GetCount" (byval self as wxArrayString ptr) as integer
declare sub wxSleep_func cdecl alias "wxSleep_func" (byval num as integer)
declare sub wxYield_func cdecl alias "wxYield_func" ()
declare sub wxBeginBusyCursor_func cdecl alias "wxBeginBusyCursor_func" ()
declare sub wxEndBusyCursor_func cdecl alias "wxEndBusyCursor_func" ()
declare function wxWindowDisabler cdecl alias "wxWindowDisabler_ctor" (byval winToSkip as wxWindow ptr) as wxWindowDisabler ptr
declare sub wxWindowDisabler_dtor cdecl alias "wxWindowDisabler_dtor" (byval self as wxWindowDisabler ptr)
declare function wxBusyInfo cdecl alias "wxBusyInfo_ctor" (byval message as zstring ptr, byval parent as wxWindow ptr) as wxBusyInfo ptr
declare sub wxBusyInfo_dtor cdecl alias "wxBusyInfo_dtor" (byval self as wxBusyInfo ptr)
declare sub wxMutexGuiEnter_func cdecl alias "wxMutexGuiEnter_func" ()
declare sub wxMutexGuiLeave_func cdecl alias "wxMutexGuiLeave_func" ()
declare function wxSize cdecl alias "wxSize_ctor" (byval x as integer, byval y as integer) as wxSize ptr
declare sub wxSize_dtor cdecl alias "wxSize_dtor" (byval self as wxSize ptr)
declare sub wxSize_SetWidth cdecl alias "wxSize_SetWidth" (byval self as wxSize ptr, byval w as integer)
declare sub wxSize_SetHeight cdecl alias "wxSize_SetHeight" (byval self as wxSize ptr, byval h as integer)
declare function wxSize_GetWidth cdecl alias "wxSize_GetWidth" (byval self as wxSize ptr) as integer
declare function wxSize_GetHeight cdecl alias "wxSize_GetHeight" (byval self as wxSize ptr) as integer

declare function wxRect cdecl alias "wxRect_ctor" (byval x as integer, byval y as integer, byval w as integer, byval h as integer) as wxRect ptr
declare sub wxRect_dtor cdecl alias "wxRect_dtor" (byval self as wxRect ptr)
declare sub wxRect_RegisterDisposable cdecl alias "wxRect_RegisterDisposable" (byval self as _Rect ptr, byval onDispose as Virtual_Dispose)
declare function wxRect_GetX cdecl alias "wxRect_GetX" (byval self as wxRect ptr) as integer
declare sub wxRect_SetX cdecl alias "wxRect_SetX" (byval self as wxRect ptr, byval x as integer)
declare function wxRect_GetY cdecl alias "wxRect_GetY" (byval self as wxRect ptr) as integer
declare sub wxRect_SetY cdecl alias "wxRect_SetY" (byval self as wxRect ptr, byval y as integer)
declare function wxRect_GetWidth cdecl alias "wxRect_GetWidth" (byval self as wxRect ptr) as integer
declare sub wxRect_SetWidth cdecl alias "wxRect_SetWidth" (byval self as wxRect ptr, byval w as integer)
declare function wxRect_GetHeight cdecl alias "wxRect_GetHeight" (byval self as wxRect ptr) as integer
declare sub wxRect_SetHeight cdecl alias "wxRect_SetHeight" (byval self as wxRect ptr, byval h as integer)

#endif
