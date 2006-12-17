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


'' fbdoc_misc - things that don't go anywhere else
''
'' chng: jun/2006 written [coderJeff]
''

#include once "fbdoc_defs.bi"
#include once "CPage.bi"
#include once "CPageList.bi"
#include once "fbdoc_string.bi"
#include once "fbdoc_misc.bi"
#include once "fbdoc_keywords.bi"

namespace fb.fbdoc

	'':::::
	sub misc_dump_titles _
		( _
			byval paglist as CPageList ptr, _
			byval sFileName as zstring ptr _
		)

		dim as CPage ptr page
		dim as any ptr page_i
		dim as string sName, sTitle1, sTitle2
		dim as integer h
		dim as string k

		h = freefile

		? "Generating pages titles list:"

		if( open(*sFileName for output as #h) = 0 ) then

			? "Writing '" + *sFileName + "'"

			page = paglist->NewEnum( @page_i )
			while( page )
				sName = page->GetName()

				sTitle1 = FormatPageTitle( page->GetPageTitle() )
				'sTitle1 = page->GetPageTitle()
				'k = fbdoc_FindKeyword( sTitle1 )
				'if( len(k) > 0 ) then
				'	sTitle1 = k
				'end if	
				
				sTitle2 = FormatPageTitle( page->GetLinkTitle() )
				'sTitle2 = page->GetLinkTitle()
				'k = fbdoc_FindKeyword( sTitle2 )
				'if( len(k) > 0 ) then
				'	sTitle2 = k
				'end if	

				? #h, """"; sName; """,""";  sTitle1; """,""";  sTitle2; """"
				page = paglist->NextEnum( @page_i )
			wend

			close #h
		else

			? "Unable to write '" + *sFileName + "'"

		end if

	end sub

end namespace
