/*
 * The contents of this file are subject to the MonetDB Public
 * License Version 1.0 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at 
 * http://monetdb.cwi.nl/Legal/MonetDBLicense-1.0.html
 * 
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 * 
 * The Original Code is the Monet Database System.
 * 
 * The Initial Developer of the Original Code is CWI.
 * Portions created by CWI are Copyright (C) 1997-2002 CWI.  
 * All Rights Reserved.
 * 
 * Contributor(s):
 * 		Martin Kersten <Martin.Kersten@cwi.nl>
 * 		Peter Boncz <Peter.Boncz@cwi.nl>
 * 		Niels Nes <Niels.Nes@cwi.nl>
 * 		Stefan Manegold  <Stefan.Manegold@cwi.nl>
 */

/**********************************************************************
 * SQLBindParam()
 * CLI Compliance: ISO 92
 *
 * Author: Sjoerd Mullender
 * Date  : 4 sep 2003
 *
 **********************************************************************/

#include "ODBCGlobal.h"
#include "ODBCStmt.h"


SQLRETURN SQLBindParam(
	SQLHSTMT hStmt,
	SQLUSMALLINT ParameterNumber,
	SQLSMALLINT ValueType,
	SQLSMALLINT ParameterType,
	SQLULEN LengthPrecision,
	SQLSMALLINT ParameterScale,
	SQLPOINTER ParameterValue,
	SQLLEN *StrLen_or_Ind)
{
	ODBCStmt * stmt = (ODBCStmt *) hStmt;

	(void) ParameterNumber;	/* Stefan: unused!? */
	(void) ValueType;	/* Stefan: unused!? */
	(void) ParameterType;	/* Stefan: unused!? */
	(void) LengthPrecision;	/* Stefan: unused!? */
	(void) ParameterScale;	/* Stefan: unused!? */
	(void) ParameterValue;	/* Stefan: unused!? */
	(void) StrLen_or_Ind;	/* Stefan: unused!? */

	if (! isValidStmt(stmt))
		return SQL_INVALID_HANDLE;

	clearStmtErrors(stmt);

	/* TODO: implement the requested behavior */

	/* for now always return error: Driver does not support this function */
	addStmtError(stmt, "IM001", NULL, 0);
	return SQL_ERROR;
}
