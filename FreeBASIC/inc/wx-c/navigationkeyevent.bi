''
''
'' navigationkeyevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_navigationkeyevent_bi__
#define __wxc_navigationkeyevent_bi__

#include once "wx-c/wx.bi"

declare function wxNavigationKeyEvent cdecl alias "wxNavigationKeyEvent_ctor" () as wxNavigationKeyEvent ptr
declare function wxNavigationKeyEvent_GetDirection cdecl alias "wxNavigationKeyEvent_GetDirection" (byval self as wxNavigationKeyEvent ptr) as integer
declare sub wxNavigationKeyEvent_SetDirection cdecl alias "wxNavigationKeyEvent_SetDirection" (byval self as wxNavigationKeyEvent ptr, byval bForward as integer)
declare function wxNavigationKeyEvent_IsWindowChange cdecl alias "wxNavigationKeyEvent_IsWindowChange" (byval self as wxNavigationKeyEvent ptr) as integer
declare sub wxNavigationKeyEvent_SetWindowChange cdecl alias "wxNavigationKeyEvent_SetWindowChange" (byval self as wxNavigationKeyEvent ptr, byval bIs as integer)
declare function wxNavigationKeyEvent_GetCurrentFocus cdecl alias "wxNavigationKeyEvent_GetCurrentFocus" (byval self as wxNavigationKeyEvent ptr) as wxWindow ptr
declare sub wxNavigationKeyEvent_SetCurrentFocus cdecl alias "wxNavigationKeyEvent_SetCurrentFocus" (byval self as wxNavigationKeyEvent ptr, byval win as wxWindow ptr)
declare sub wxNavigationKeyEvent_SetFlags cdecl alias "wxNavigationKeyEvent_SetFlags" (byval self as wxNavigationKeyEvent ptr, byval flags as integer)

#endif
