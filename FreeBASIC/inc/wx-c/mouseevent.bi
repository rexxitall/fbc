''
''
'' mouseevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_mouseevent_bi__
#define __wxc_mouseevent_bi__

#include once "wx-c/wx.bi"

declare function wxMouseEvent cdecl alias "wxMouseEvent_ctor" (byval mouseType as wxEventType) as wxMouseEvent ptr
declare function wxMouseEvent_IsButton cdecl alias "wxMouseEvent_IsButton" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_ButtonDown cdecl alias "wxMouseEvent_ButtonDown" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_ButtonDown2 cdecl alias "wxMouseEvent_ButtonDown2" (byval self as wxMouseEvent ptr, byval button as integer) as integer
declare function wxMouseEvent_ButtonDClick cdecl alias "wxMouseEvent_ButtonDClick" (byval self as wxMouseEvent ptr, byval but as integer) as integer
declare function wxMouseEvent_ButtonUp cdecl alias "wxMouseEvent_ButtonUp" (byval self as wxMouseEvent ptr, byval but as integer) as integer
declare function wxMouseEvent_Button cdecl alias "wxMouseEvent_Button" (byval self as wxMouseEvent ptr, byval but as integer) as integer
declare function wxMouseEvent_ButtonIsDown cdecl alias "wxMouseEvent_ButtonIsDown" (byval self as wxMouseEvent ptr, byval but as integer) as integer
declare function wxMouseEvent_GetButton cdecl alias "wxMouseEvent_GetButton" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_ControlDown cdecl alias "wxMouseEvent_ControlDown" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_MetaDown cdecl alias "wxMouseEvent_MetaDown" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_AltDown cdecl alias "wxMouseEvent_AltDown" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_ShiftDown cdecl alias "wxMouseEvent_ShiftDown" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_LeftDown cdecl alias "wxMouseEvent_LeftDown" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_MiddleDown cdecl alias "wxMouseEvent_MiddleDown" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_RightDown cdecl alias "wxMouseEvent_RightDown" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_LeftUp cdecl alias "wxMouseEvent_LeftUp" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_MiddleUp cdecl alias "wxMouseEvent_MiddleUp" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_RightUp cdecl alias "wxMouseEvent_RightUp" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_LeftDClick cdecl alias "wxMouseEvent_LeftDClick" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_MiddleDClick cdecl alias "wxMouseEvent_MiddleDClick" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_RightDClick cdecl alias "wxMouseEvent_RightDClick" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_LeftIsDown cdecl alias "wxMouseEvent_LeftIsDown" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_MiddleIsDown cdecl alias "wxMouseEvent_MiddleIsDown" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_RightIsDown cdecl alias "wxMouseEvent_RightIsDown" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_Dragging cdecl alias "wxMouseEvent_Dragging" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_Moving cdecl alias "wxMouseEvent_Moving" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_Entering cdecl alias "wxMouseEvent_Entering" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_Leaving cdecl alias "wxMouseEvent_Leaving" (byval self as wxMouseEvent ptr) as integer
declare sub wxMouseEvent_GetPosition cdecl alias "wxMouseEvent_GetPosition" (byval self as wxMouseEvent ptr, byval pos as wxPoint ptr)
declare sub wxMouseEvent_LogicalPosition cdecl alias "wxMouseEvent_LogicalPosition" (byval self as wxMouseEvent ptr, byval dc as wxDC ptr, byval pos as wxPoint ptr)
declare function wxMouseEvent_GetWheelRotation cdecl alias "wxMouseEvent_GetWheelRotation" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_GetWheelDelta cdecl alias "wxMouseEvent_GetWheelDelta" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_GetLinesPerAction cdecl alias "wxMouseEvent_GetLinesPerAction" (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_IsPageScroll cdecl alias "wxMouseEvent_IsPageScroll" (byval self as wxMouseEvent ptr) as integer

#endif
