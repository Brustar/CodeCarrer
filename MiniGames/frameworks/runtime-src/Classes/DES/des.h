//
//  DesEncrypt.h
//  SocketCenter
//
//  Created by zhoukaijun on 14-8-28.
//  Copyright (c) 2014Äê zhoukaijun. All rights reserved.
//

#ifndef __SocketCenter__DesEncrypt__
#define __SocketCenter__DesEncrypt__

#include <iostream>
#include <vector>

class _baseDes
{
public:
	enum CypherMode
	{
		ECB = 0,
		CBC = 1
	};
	enum PaddingMode
	{
		PAD_NORMAL = 1,
		PAD_PHCS5 = 2
	};

	_baseDes(CypherMode mode = ECB, std::string IV = "", std::string pad = "", PaddingMode padMode = PAD_NORMAL);

	std::string getKey() { return m_key; }
	void setKey(const std::string &key) { m_key = key; }
	CypherMode getMode() { return m_mode; }
	void setMode(CypherMode mode) { m_mode = mode; }
	std::string getPadding() { return m_padding; }
	void setPadding(const std::string &pad) { m_padding = _guardAgainstUnicode(pad); }
	PaddingMode getPadMode() { return m_padMode; }
	void setPadMode(PaddingMode mode) { m_padMode = mode; }
	std::string getIV() { return m_IV; }
	void setIV(const std::string &IV);

	std::string strAppendstrTimes(std::string data, const std::string &apdStr, unsigned int times);
	std::string strRstrip(std::string data, const std::string &stripStr);
	std::string _padData(const std::string &data, std::string pad);
	std::string _padData(std::string data, std::string pad, PaddingMode padMode);
	std::string _unpadData(std::string data, std::string pad);
	std::string _unpadData(std::string data, std::string pad, PaddingMode padMode);
	std::string _guardAgainstUnicode(std::string data);
protected:
	int m_blockSize;
private:
	CypherMode m_mode;
	std::string m_IV;
	std::string m_padding;
	PaddingMode m_padMode;

	std::string m_key;
};

typedef std::vector<int> BitList;

class DesEncrypt: public _baseDes
{
public:
	DesEncrypt(std::string key, CypherMode mode = ECB, std::string IV = "", std::string pad = "", PaddingMode padMode = PAD_NORMAL);

	void setKey(const std::string &key);
	BitList _String_to_BitList(std::string data);
	std::string _BitList_to_String(const BitList &data);
	BitList _permutate(const BitList &table, const BitList &block);
	void _create_sub_keys();
	BitList _des_crypt(BitList block, char cryptType);
	std::string crypt(std::string data, char cryptType);
	std::string encrypt(std::string data);
	std::string encrypt(std::string data, std::string pad);
	std::string encrypt(std::string data, std::string pad, PaddingMode padMode);
	std::string decrypt(std::string data);
	std::string decrypt(std::string data, std::string pad);
	std::string decrypt(std::string data, std::string pad, PaddingMode padMode);
private:
	int m_keySize;
	BitList m_L;
	BitList m_R;
	BitList m_Kn[16];
	BitList m_final;
};

#ifdef __cplusplus
extern "C" {
#endif
#include "lua.h"

	int luaopen_des(lua_State* tolua_S);

#ifdef __cplusplus
}
#endif

#endif /* defined(__SocketCenter__DesEncrypt__) */
