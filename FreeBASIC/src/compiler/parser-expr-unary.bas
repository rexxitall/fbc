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


'' unary operators (NOT, @, *, ...) parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

declare function 	cAnonUDT			( byref expr as ASTNODE ptr ) as integer

declare function 	cCastingExpr		( byref expr as ASTNODE ptr ) as integer

'':::::
''NegNotExpression=   ('-'|'+'|) ExpExpression
''				  |   NOT RelExpression
''				  |   HighestPresExpr .
''
function cNegNotExpression( byref negexpr as ASTNODE ptr ) as integer

	function = FALSE

	select case lexGetToken( )
	'' '-'
	case CHAR_MINUS
		lexSkipToken( )

		'' ExpExpression
		if( cExpExpression( negexpr ) = FALSE ) then
			exit function
		end if

		negexpr = astNewUOP( IR_OP_NEG, negexpr )

    	if( negexpr = NULL ) Then
    		hReportError( FB_ERRMSG_TYPEMISMATCH )
    		exit function
    	end if

		return TRUE

	'' '+'
	case CHAR_PLUS
		lexSkipToken( )

		'' ExpExpression
		if( cExpExpression( negexpr ) = FALSE ) then
			exit function
		end if

    	'' not numeric? can't operate..
    	if( astGetDataClass( negexpr ) >= FB_DATACLASS_STRING ) then
    		hReportError( FB_ERRMSG_TYPEMISMATCH )
    		exit function
    	end if

    	return TRUE

	'' NOT
	case FB_TK_NOT
		lexSkipToken( )

		'' RelExpression
		if( cRelExpression( negexpr ) = FALSE ) then
			exit function
		end if

		negexpr = astNewUOP( IR_OP_NOT, negexpr )

    	if( negexpr = NULL ) Then
    		hReportError( FB_ERRMSG_TYPEMISMATCH )
    		exit function
    	end if

		return TRUE
	end select

	function = cHighestPrecExpr( negexpr )

end function

''::::
'' HighestPrecExpr=   AddrOfExpression
''				  |	  ( DerefExpr
''				  	  |	CastingExpr
''					  | PtrTypeCastingExpr
''				  	  | ParentExpression
''					  ) FuncPtrOrDerefFields?
''				  |	  AnonUDT
''				  |   Atom .
''
function cHighestPrecExpr( byref highexpr as ASTNODE ptr ) as integer
	dim as FBSYMBOL ptr subtype
	dim as integer isfuncptr, dtype

	select case lexGetToken( )
	'' AddrOfExpression
	case FB_TK_ADDROFCHAR
		return cAddrOfExpression( highexpr )

	'' DerefExpr
	case FB_TK_DEREFCHAR
		if( cDerefExpression( highexpr ) = FALSE ) then
			exit function
		end if

	'' ParentExpression
	case CHAR_LPRNT
		if( cParentExpression( highexpr ) = FALSE ) then
			exit function
		end if

	case else

		select case as const lexGetToken( )
		'' AddrOfExpression
		case FB_TK_VARPTR, FB_TK_PROCPTR, FB_TK_SADD, FB_TK_STRPTR
			return cAddrOfExpression( highexpr )

		'' CastingExpr
		case FB_TK_CAST
			if( cCastingExpr( highexpr ) = FALSE ) then
				exit function
			end if

		'' PtrTypeCastingExpr
		case FB_TK_CPTR
			if( cPtrTypeCastingExpr( highexpr ) = FALSE ) then
				exit function
			end if

		'' TYPE
		case FB_TK_TYPE
			return cAnonUDT( highexpr )

		'' Atom
		case else
			return cAtom( highexpr )

		end select

	end select

    '' FuncPtrOrDerefFields?
	dtype = astGetDataType( highexpr )
	if( dtype >= FB_DATATYPE_POINTER ) then
		isfuncptr = FALSE
		if( dtype = FB_DATATYPE_POINTER+FB_DATATYPE_FUNCTION ) then
			if( lexGetToken( ) = CHAR_LPRNT ) then
				isfuncptr = TRUE
			end if
		end if

		subtype = astGetSubType( highexpr )

		cFuncPtrOrDerefFields( dtype, subtype, highexpr, isfuncptr, TRUE )
	end if

	function = (hGetLastError() = FB_ERRMSG_OK)

end function

'':::::
'' AnonUDT			=	TYPE ('<' Symbol '>')? '(' ... ')'
function cAnonUDT( byref expr as ASTNODE ptr ) as integer
    dim as FBSYMBOL ptr tmpsym, subtype

	function = FALSE

	'' TYPE
	lexSkipToken( )

    '' ('<' Symbol '>')?
    if( lexGetToken( ) = FB_TK_LT ) then
    	lexSkipToken( )
    	tmpsym = lexGetSymbol( )
    	if( tmpsym = NULL ) then
			hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
			exit function
    	end if

    	if( symbIsUDT( tmpsym ) = FALSE ) then
			hReportError( FB_ERRMSG_INVALIDDATATYPES )
			exit function
    	end if

    	subtype = tmpsym

    	lexSkipToken( )

    	'' '>'
    	if( lexGetToken( ) <> FB_TK_GT ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
    	end if
    	lexSkipToken( )

    else
    	subtype = env.ctxsym

    	if( subtype = NULL ) then
			hReportError( FB_ERRMSG_SYNTAXERROR, TRUE )
			exit function
    	end if

    	if( symbIsUDT( subtype ) = FALSE ) then
			hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
			exit function
		end if
    end if

	'' create a temp var
	tmpsym = symbAddTempVar( FB_DATATYPE_USERDEF, subtype )

    '' let the initializer do the rest..
    if( cSymbolInit( tmpsym ) = FALSE ) then
    	exit function
    end if

    '' create a var expression
    expr = astNewVAR( tmpsym, 0, FB_DATATYPE_USERDEF, subtype )

    function = TRUE

end function

'':::::
private function hCast( byref expr as ASTNODE ptr, _
						byval ptronly as integer _
			  		  ) as integer

    dim as integer dtype, lgt, ptrcnt
    dim as FBSYMBOL ptr subtype

	function = FALSE

	'' '('
	hMatchLPRNT( )

    '' DataType
    if( cSymbolType( dtype, subtype, lgt, ptrcnt ) = FALSE ) then
    	hReportError( FB_ERRMSG_SYNTAXERROR )
    	exit function
    end if

	'' check for invalid types
	select case dtype
	case FB_DATATYPE_VOID, FB_DATATYPE_FIXSTR
		hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
		exit function
	end select

	if( ptronly ) then
		'' check if it's a pointer
		if( dtype < FB_DATATYPE_POINTER ) then
			hReportError( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
			exit function
		end if

	else
		if( dtype >= FB_DATATYPE_POINTER ) then
			ptronly = TRUE
		end if
	end if

	'' ','
	hMatchCOMMA( )

	'' expression
	if( cExpression( expr ) = FALSE ) then
		exit function
	end if

	if( ptronly ) then
		select case astGetDataType( expr )
		case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT, is >= FB_DATATYPE_POINTER

		case else
			hReportError( FB_ERRMSG_EXPECTEDPOINTER )
			exit function
		end select
	end if

	expr = astNewCONV( iif( ptronly, IR_OP_TOPOINTER, INVALID ), _
					   dtype, subtype, expr, TRUE )
    if( expr = NULL ) Then
    	hReportError( FB_ERRMSG_TYPEMISMATCH, TRUE )
    	exit function
    end if

	'' ')'
	hMatchRPRNT( )

	function = TRUE

end function

'':::::
'' CastingExpr	=	CAST '(' DataType ',' Expression ')'
''
function cCastingExpr( byref expr as ASTNODE ptr ) as integer

	'' CAST
	lexSkipToken( )

	function = hCast( expr, FALSE )

end function

'':::::
'' PtrTypeCastingExpr	=   CPTR '(' DataType ',' Expression{int|uint|ptr} ')'
''
function cPtrTypeCastingExpr( byref expr as ASTNODE ptr ) as integer

	'' CPTR
	lexSkipToken( )

	function = hCast( expr, TRUE )

end function

'':::::
private function hDoDeref( byval cnt as integer, _
						   byref expr as ASTNODE ptr, _
					       byval dtype as integer, _
					       byval subtype as FBSYMBOL ptr _
					     ) as integer

	function = INVALID

	if( (expr = NULL) or (cnt <= 0) ) then
		exit function
	end if

	do while( cnt > 0 )
		'' not a pointer?
		if( dtype < FB_DATATYPE_POINTER ) then
			hReportError( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
			exit function
		end if

		dtype -= FB_DATATYPE_POINTER

		'' incomplete type?
		if( (dtype = FB_DATATYPE_VOID) or (dtype = FB_DATATYPE_FWDREF) ) then
			hReportError( FB_ERRMSG_INCOMPLETETYPE, TRUE )
			exit function
		end if

		'' null pointer checking
		if( env.clopt.extraerrchk ) then
			expr = astNewPTRCHK( expr, lexLineNum( ) )
		end if

		expr = astNewPTR( 0, expr, dtype, subtype )

		cnt -= 1
	loop

    function = dtype

end function

'':::::
''DerefExpression	= 	DREF+ HighestPresExpr .
''
function cDerefExpression( byref derefexpr as ASTNODE ptr ) as integer
    dim as FBSYMBOL ptr subtype
    dim as integer derefcnt, dtype
    dim as ASTNODE ptr funcexpr

	function = FALSE

	'' DREF?
	if( lexGetToken( ) <> FB_TK_DEREFCHAR ) then
		exit function
	end if

	'' DREF+
    derefcnt = 0
	do
		lexSkipToken( )
		derefcnt += 1
	loop while( lexGetToken( ) = FB_TK_DEREFCHAR )

	'' HighestPresExpr
	if( cHighestPrecExpr( derefexpr ) = FALSE ) then
        hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
        exit function
	end if

	''
	dtype   = astGetDataType( derefexpr )
	subtype = astGetSubType( derefexpr )

	''
	dtype = hDoDeref( derefcnt, derefexpr, dtype, subtype )
	if( dtype = INVALID ) then
		exit function
	end if

	function = TRUE

end function

'':::::
private function hProcPtrBody( byval proc as FBSYMBOL ptr, _
							   byref addrofexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr expr
	dim as FBSYMBOL ptr sym

	function = FALSE

	'' '('')'?
	if( hMatch( CHAR_LPRNT ) ) then
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
			exit function
		end if
	end if

	'' resolve overloaded procs
	if( symbIsOverloaded( proc ) ) then
        if( env.ctxsym <> NULL ) then
        	if( symbIsProc( env.ctxsym ) ) then
        		sym = symbFindOverloadProc( proc, env.ctxsym )
        		if( sym <> NULL ) then
        			proc = sym
        		end if
        	end if
        end if
	end if

	expr = astNewVAR( proc, 0, FB_DATATYPE_FUNCTION, proc )
	addrofexpr = astNewADDR( IR_OP_ADDROF, expr )

	''
	symbSetProcIsCalled( proc, TRUE )

	function = (addrofexpr <> NULL)

end function

'':::::
private function hVarPtrBody( byref addrofexpr as ASTNODE ptr) as integer

	function = FALSE

	if( cHighestPrecExpr( addrofexpr ) = FALSE ) then
		exit function
	end if

	select case as const astGetClass( addrofexpr )
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_PTR

	case AST_NODECLASS_FIELD
		'' can't take address of bitfields..
		if( astGetDataType( addrofexpr ) = FB_DATATYPE_BITFIELD ) then
			hReportError( FB_ERRMSG_INVALIDDATATYPES )
			exit function
		end if

	case else
		hReportErrorEx( FB_ERRMSG_INVALIDDATATYPES, "for @ or VARPTR" )
		exit function
	end select

	addrofexpr = astNewADDR( IR_OP_ADDROF, addrofexpr )

    function = (addrofexpr <> NULL)

end function

'':::::
''AddrOfExpression  =   VARPTR '(' HighPrecExpr ')'
''					|   PROCPTR '(' Proc ('('')')? ')'
'' 					| 	'@' (Proc ('('')')? | HighPrecExpr)
''					|   SADD|STRPTR '(' Variable{str}|Const{str}|Literal{str} ')' .
''
function cAddrOfExpression( byref addrofexpr as ASTNODE ptr ) as integer
    dim as ASTNODE ptr expr
    dim as integer dtype
    dim as FBSYMBOL ptr sym

	function = FALSE

	'' '@' (Proc ('('')')? | Variable)
	if( lexGetToken( ) = FB_TK_ADDROFCHAR ) then
		lexSkipToken( )

		'' proc?
		if( lexGetClass( ) = FB_TKCLASS_IDENTIFIER ) then
			sym = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_PROC )
			if( sym <> NULL ) then
				lexSkipToken( )
				return hProcPtrBody( sym, addrofexpr )
			end if
        end if

		return hVarPtrBody( addrofexpr )
	end if

	select case as const lexGetToken( )
	'' VARPTR '(' Variable ')'
	case FB_TK_VARPTR
		lexSkipToken( )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDLPRNT )
			exit function
		end if

		if( hVarPtrBody( addrofexpr ) = FALSE ) then
			exit function
		end if

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
			exit function
		end if

		return TRUE

	'' PROCPTR '(' Proc ('('')')? ')'
	case FB_TK_PROCPTR
		lexSkipToken( )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDLPRNT )
			exit function
		end if

		'' proc?
		sym = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_PROC )
		if( sym = NULL ) then
			hReportError( FB_ERRMSG_UNDEFINEDSYMBOL )
			exit function
		else
			lexSkipToken( )
		end if

		if( hProcPtrBody( sym, addrofexpr ) = FALSE ) then
			exit function
		end if

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
			exit function
		end if

		return TRUE

	'' SADD|STRPTR '(' Variable{str} ')'
	case FB_TK_SADD, FB_TK_STRPTR
		lexSkipToken( )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDLPRNT )
			exit function
		end if

		if( cLiteral( expr ) = FALSE ) then
			if( cConstant( expr ) = FALSE ) then
				if( cVariable( expr ) = FALSE ) then
					hReportError( FB_ERRMSG_INVALIDDATATYPES )
					exit function
				end if
			end if
		end if

		dtype = astGetDataType( expr )
		if( hIsString( dtype ) = FALSE ) then
			hReportError( FB_ERRMSG_INVALIDDATATYPES )
			exit function
		end if

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
			exit function
		end if

		if( dtype = FB_DATATYPE_STRING ) then
			expr = astNewADDR( IR_OP_DEREF, expr )
		else
			expr = astNewADDR( IR_OP_ADDROF, expr )
		end if

		if( dtype <> FB_DATATYPE_WCHAR ) then
			dtype = FB_DATATYPE_CHAR
		end if

		addrofexpr = astNewCONV( IR_OP_TOPOINTER, _
								 FB_DATATYPE_POINTER+dtype, NULL, _
								 expr )

		return (addrofexpr <> NULL)
	end select

end function

