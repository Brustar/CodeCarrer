/**
*  $Id: md5.h,v 1.2 2006/03/03 15:04:49 tomas Exp $
*  Cryptographic module for Lua.
*  @author  Roberto Ierusalimschy
*/


#ifndef md5_h
#define md5_h
#ifdef __cplusplus
extern "C"{
#endif
#include "lua.h"
#ifdef __cplusplus
}
#endif

#define HASHSIZE       16

void md5 (const char *message, long len, char *output);
int luaopen_md5_core(lua_State *L);


#endif
