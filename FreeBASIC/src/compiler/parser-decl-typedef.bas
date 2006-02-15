''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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


'' typedef (TYPE foo AS bar) declarations
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"

'':::::
'' Typedef		= TYPE ((symbol AS DataType (',')?)+
''					   AS DataType (symbol (',')?)+
''
function cTypedefDecl( byval pid as zstring ptr ) as integer static
    static as zstring * FB_MAXNAMELEN+1 id, tname
    dim as zstring ptr ptname
    dim as integer typ, lgt, ptrcnt, isfwd, ismult
    dim as FBSYMBOL ptr subtype

    function = FALSE

    ismult = (pid = NULL)

    if( ismult ) then
    	isfwd = (cSymbolType( typ, subtype, lgt, ptrcnt ) = NULL)
    	if( isfwd ) then
    		if( hGetLastError( ) <> FB_ERRMSG_OK ) then
    			exit function
    		end if

    		lexEatToken( tname )
    		ptname = @tname

			if( ptrcnt = 0 ) then
				'' (PTR|POINTER)*
				do
					select case lexGetToken( )
					case FB_TK_PTR, FB_TK_POINTER
						lexSkipToken( )
						typ += FB_DATATYPE_POINTER
						ptrcnt += 1
					case else
						exit do
					end select
				loop
			end if
    	end if

    end if

    do
		if( ismult = FALSE ) then
    		isfwd = (cSymbolType( typ, subtype, lgt, ptrcnt ) = NULL)
    		if( isfwd ) then
    			if( hGetLastError( ) <> FB_ERRMSG_OK ) then
    				exit function
    			end if
    			ptname = lexGetText( )
    		end if

    	else
    		if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
    			hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    			exit function
		    end if

			lexEatToken( id )
			pid = @id
    	end if

    	if( isfwd ) then
    		'' pointing to itself? then it's a void..
    		if( *ptname = *pid ) then
    			typ 	= FB_DATATYPE_VOID
    			subtype = NULL
    			lgt 	= 0

    		'' else, create a forward reference (or lookup one)
    		else
    			typ 	= FB_DATATYPE_FWDREF
    			subtype = symbAddFwdRef( ptname )
				lgt 	= -1
				if( subtype = NULL ) then
					subtype = symbFindByNameAndClass( ptname, FB_SYMBCLASS_FWDREF )
					if( subtype = NULL ) then
						hReportError( FB_ERRMSG_DUPDEFINITION )
						exit function
					end if
				end if
    		end if

			if( ismult = FALSE ) then
    			lexSkipToken( )

				if( ptrcnt = 0 ) then
					'' (PTR|POINTER)*
					do
						select case lexGetToken( )
						case FB_TK_PTR, FB_TK_POINTER
							lexSkipToken( )
							typ += FB_DATATYPE_POINTER
							ptrcnt += 1
						case else
							exit do
						end select
					loop
				end if

			else
				typ += ptrcnt * FB_DATATYPE_POINTER
			end if
    	end if

        ''
    	if( symbAddTypedef( pid, typ, subtype, ptrcnt, lgt ) = NULL ) then
			hReportError( FB_ERRMSG_DUPDEFINITION, TRUE )
			exit function
    	end if

    '' ','?
    loop while( hMatch( FB_TK_DECLSEPCHAR ) )

	function = TRUE

end function

