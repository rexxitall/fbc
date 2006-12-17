#ifndef __FBDOC_BUILDTOC_BI__
#define __FBDOC_BUILDTOC_BI__

''  fbdoc - FreeBASIC User's Manual Converter/Generator
''	Copyright (C) 2006, 2007 Jeffery R. Marshall (coder[at]execulink.com)
''  and the FreeBASIC development team.
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


#include once "CPageList.bi"

namespace fb.fbdoc

	declare function FBDoc_BuildTOC _
		( _
			byval tocpagename as zstring ptr, _
			byval tocpagetitle as zstring ptr, _
			byval paglist as CPageList ptr ptr, _
			byval toclist as CPageList ptr ptr _
		) as integer

	declare function FBDoc_BuildSinglePage _
		( _
			byval toc_pagename as zstring ptr, _
			byval toc_pagetitle as zstring ptr, _
			byval paglist as CPageList ptr ptr, _
			byval toclist as CPageList ptr ptr _
		) as integer

end namespace

#endif
