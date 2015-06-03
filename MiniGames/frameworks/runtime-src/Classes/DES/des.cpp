#include "des.h"
#include <assert.h>

#ifdef __cplusplus
extern "C" {
#endif
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
#ifdef __cplusplus
}
#endif

static int s_pc1[] = {56, 48, 40, 32, 24, 16,  8,
	0, 57, 49, 41, 33, 25, 17,
	9,  1, 58, 50, 42, 34, 26,
	18, 10,  2, 59, 51, 43, 35,
	62, 54, 46, 38, 30, 22, 14,
	6, 61, 53, 45, 37, 29, 21,
	13,  5, 60, 52, 44, 36, 28,
	20, 12,  4, 27, 19, 11,  3};
static int s_left_rotations[] = {1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1};
static int s_pc2[] = {13, 16, 10, 23,  0,  4,
	2, 27, 14,  5, 20,  9,
	22, 18, 11,  3, 25,  7,
	15,  6, 26, 19, 12,  1,
	40, 51, 30, 36, 46, 54,
	29, 39, 50, 44, 32, 47,
	43, 48, 38, 55, 33, 52,
	45, 41, 49, 35, 28, 31};
static int s_ip[] = {57, 49, 41, 33, 25, 17, 9,  1,
	59, 51, 43, 35, 27, 19, 11, 3,
	61, 53, 45, 37, 29, 21, 13, 5,
	63, 55, 47, 39, 31, 23, 15, 7,
	56, 48, 40, 32, 24, 16, 8,  0,
	58, 50, 42, 34, 26, 18, 10, 2,
	60, 52, 44, 36, 28, 20, 12, 4,
	62, 54, 46, 38, 30, 22, 14, 6};
static int s_expansion_table[] = {31,  0,  1,  2,  3,  4,
	3,  4,  5,  6,  7,  8,
	7,  8,  9, 10, 11, 12,
	11, 12, 13, 14, 15, 16,
	15, 16, 17, 18, 19, 20,
	19, 20, 21, 22, 23, 24,
	23, 24, 25, 26, 27, 28,
	27, 28, 29, 30, 31,  0};
static int s_sbox[][64] = {
	{//S1
		14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7,
			0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8,
			4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0,
			15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13
	},
	{//S2
		15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10,
			3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5,
			0, 14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15,
			13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9
		},
		{//S3
			10, 0, 9, 14, 6, 3, 15, 5, 1, 13, 12, 7, 11, 4, 2, 8,
				13, 7, 0, 9, 3, 4, 6, 10, 2, 8, 5, 14, 12, 11, 15, 1,
				13, 6, 4, 9, 8, 15, 3, 0, 11, 1, 2, 12, 5, 10, 14, 7,
				1, 10, 13, 0, 6, 9, 8, 7, 4, 15, 14, 3, 11, 5, 2, 12
		},
		{//S4
			7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15,
				13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9,
				10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4,
				3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14
			},
			{//S5
				2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9,
					14, 11, 2, 12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6,
					4, 2, 1, 11, 10, 13, 7, 8, 15, 9, 12, 5, 6, 3, 0, 14,
					11, 8, 12, 7, 1, 14, 2, 13, 6, 15, 0, 9, 10, 4, 5, 3
			},
			{//S6
				12, 1, 10, 15, 9, 2, 6, 8, 0, 13, 3, 4, 14, 7, 5, 11,
					10, 15, 4, 2, 7, 12, 9, 5, 6, 1, 13, 14, 0, 11, 3, 8,
					9, 14, 15, 5, 2, 8, 12, 3, 7, 0, 4, 10, 1, 13, 11, 6,
					4, 3, 2, 12, 9, 5, 15, 10, 11, 14, 1, 7, 6, 0, 8, 13
				},
				{//S7
					4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1,
						13, 0, 11, 7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6,
						1, 4, 11, 13, 12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2,
						6, 11, 13, 8, 1, 4, 10, 7, 9, 5, 0, 15, 14, 2, 3, 12
				},
				{//S8
					13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7,
						1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2,
						7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8,
						2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11
					}
};

static int s_p[] = {15, 6, 19, 20, 28, 11,
	27, 16, 0, 14, 22, 25,
	4, 17, 30, 9, 1, 7,
	23,13, 31, 26, 2, 8,
	18, 12, 29, 5, 21, 10,
	3, 24};
static int s_fp[] = {39,  7, 47, 15, 55, 23, 63, 31,
	38,  6, 46, 14, 54, 22, 62, 30,
	37,  5, 45, 13, 53, 21, 61, 29,
	36,  4, 44, 12, 52, 20, 60, 28,
	35,  3, 43, 11, 51, 19, 59, 27,
	34,  2, 42, 10, 50, 18, 58, 26,
	33,  1, 41,  9, 49, 17, 57, 25,
	32,  0, 40,  8, 48, 16, 56, 24};

static char s_ENCRYPT = 0x00;
static char s_DECRYPT = 0x01;

void printBitList(BitList array)
{
	printf("data = ");
	for(int i = 0; i < array.size(); i++)
		printf("%d ",array[i]);
	printf("\n");
}

_baseDes::_baseDes(CypherMode mode, std::string IV, std::string pad, PaddingMode padMode)
{
	m_blockSize = 8;
	if(!IV.empty())
	{
		IV = _guardAgainstUnicode(IV);
	}
	if(!pad.empty())
	{
		pad = _guardAgainstUnicode(pad);
	}
	if(!pad.empty() && (PAD_PHCS5 == padMode))
		throw "Cannot use a pad character with PAD_PKCS5";
	if(!IV.empty() && (IV.length() != m_blockSize))
		throw "Invalid Initial Value (IV), must be a multiple of 8 bytes";
	m_mode = mode;
	m_IV = IV;
	m_padding = pad;
	m_padMode = padMode;
}

void _baseDes::setIV(const std::string &IV)
{
	if(IV.empty() || (IV.length() != m_blockSize))
		throw "Invalid Initial Value (IV), must be a multiple of 8 bytes";
	m_IV = _guardAgainstUnicode(IV);
}

std::string _baseDes::strAppendstrTimes(std::string data, const std::string &apdStr, unsigned int times)
{
	while(times--)
	{
		data += apdStr;
	};
	return data;
}
std::string _baseDes::strRstrip(std::string data, const std::string &stripStr)
{
	int index = data.find_last_not_of(stripStr) + 1;
	if(index == data.length())
	{
		return data;
	}
	else
	{
		return data.substr(0, index);
	}
}

std::string _baseDes::_padData(const std::string &data, std::string pad)
{
	return _padData(data, pad, getPadMode());
}
std::string _baseDes::_padData(std::string data, std::string pad, DesEncrypt::PaddingMode padMode)
{
	if(!pad.empty() && (PAD_PHCS5 == padMode))
		throw "Cannot use a pad character with PAD_PKCS5";
	if(PAD_NORMAL == padMode)
	{
		if(0 == (data.length()%m_blockSize))
			return data;
		if(pad.empty())
			pad = getPadding();
		if(pad.empty())
			throw "Data must be a multiple of 8 bytes in length. Use padmode=PAD_PKCS5 or set the pad character.";
		int times = m_blockSize - (data.length()%m_blockSize);
		data = strAppendstrTimes(data, pad, times);
	}
	else if(PAD_PHCS5 == padMode)
	{
		int padLen = 8 - (data.length()%m_blockSize);
		std::string charStr;
		charStr += padLen;
		data = strAppendstrTimes(data, charStr, padLen);
	}
	return data;
}

std::string _baseDes::_unpadData(std::string data, std::string pad)
{
	return _unpadData(data, pad, getPadMode());
}

std::string _baseDes::_unpadData(std::string data, std::string pad, DesEncrypt::PaddingMode padMode)
{
	if(data.empty())
		return data;
	if(!pad.empty() && (PAD_PHCS5 == padMode))
		throw "Cannot use a pad character with PAD_PKCS5";
	if(PAD_NORMAL == padMode)
	{
		if(pad.empty())
			pad = getPadding();
		if(!pad.empty())
		{
			int len = data.length();
			int index = len - m_blockSize;
			std::string tmp;
			tmp = data.substr(0,index);
			tmp += strRstrip(data.substr(index,m_blockSize), pad);
			data = tmp;
		}
	}
	else if(PAD_PHCS5 == padMode)
	{
		int len = data.length();
		int padLen = data[len - 1];
		int dtSize = len - padLen;
		if(dtSize > 0)
		{
			data = data.substr(0, dtSize);
		}
		else
		{
			data = "";
		}
	}
	return data;
}

std::string _baseDes::_guardAgainstUnicode(std::string data)
{
	return data;
}


DesEncrypt::DesEncrypt(std::string key, CypherMode mode, std::string IV, std::string pad, PaddingMode padMode):_baseDes(mode, IV, pad, padMode)
{
	if(key.length() != 8)
		throw "Invalid DES key size. Key must be exactly 8 bytes long.";

	m_keySize = 8;
	for(int i = 0; i < 16; i++)
		for(int j = 0; j < 48; j++)
			m_Kn[i].push_back(0);

	setKey(key);
}

void DesEncrypt::setKey(const std::string &key)
{
	_baseDes::setKey(key);
	_create_sub_keys();
}

BitList DesEncrypt::_String_to_BitList(std::string data)
{
	int len = data.length();
	int l = len*8;
	BitList result;
	for(int i = 0; i < l; i++)
	{
		result.push_back(0);
	}
	int pos = 0;
	for(int j = 0; j < len; j++)
	{
		int ch = data[j];
		int i = 7;
		while(i>=0)
		{
			if((ch & (1 << i)) != 0)
				result[pos] = 1;
			else
				result[pos] = 0;
			pos++;
			i--;
		}
	}
	return result;
}

std::string DesEncrypt::_BitList_to_String(const BitList &data)
{
	std::string result("");
	int len = data.size();
	int pos = 0;
	int c = 0;
	while(pos < len)
	{
		c += data[pos] << (7 - (pos % 8));
		if(7 == (pos % 8))
		{
			char ch = c;
			result += ch;
			c = 0;
		}
		pos++;
	}
	return result;
}

BitList DesEncrypt::_permutate(const BitList &table, const BitList &block)
{
	BitList result;
	int len = table.size();
	for(int i = 0; i < len; i++)
	{
		result.push_back(block[table[i]]);
	}
	return result;
}

BitList getBitListByIntArray(int *num, int size)
{
	BitList result;
	for(int i = 0; i < size; i++)
	{
		result.push_back(*(num + i));
	}
	return result;
}

BitList getBitListByBitList(const BitList &array, int begin, int end)
{
	BitList result;
	for(int i = begin; i < end; i++)
	{
		result.push_back(array[i]);
	}
	return result;
}

BitList bitListAddBitList(const BitList &array1, const BitList &array2)
{
	BitList result;
	for(int i = 0; i < array1.size(); i++)
		result.push_back(array1[i]);
	for(int i = 0; i < array2.size(); i++)
		result.push_back(array2[i]);
	return result;
}

void DesEncrypt::_create_sub_keys()
{
	BitList key = _permutate(getBitListByIntArray(s_pc1, 56), _String_to_BitList(getKey()));
	m_L = getBitListByBitList(key, 0, 28);
	m_R = getBitListByBitList(key, 28, key.size());
	int i = 0;
	while(i < 16)
	{
		int j = 0;
		while(j < s_left_rotations[i])
		{
			m_L.push_back(m_L[0]);
			m_L.erase(m_L.begin());

			m_R.push_back(m_R[0]);
			m_R.erase(m_R.begin());

			j++;
		}
		m_Kn[i] = _permutate(getBitListByIntArray(s_pc2, 48), bitListAddBitList(m_L, m_R));
		i++;
	}
}

BitList DesEncrypt::_des_crypt(BitList block, char cryptType)
{
	block = _permutate(getBitListByIntArray(s_ip, 64), block);
	m_L = getBitListByBitList(block, 0, 32);
	m_R = getBitListByBitList(block, 32, block.size());

	int iteration = 15;
	int iteration_adjustment = -1;
	if(s_ENCRYPT == cryptType)
	{
		iteration = 0;
		iteration_adjustment = 1;
	}

	int i = 0;
	while(i < 16)
	{
		BitList tmpR = m_R;
		m_R = _permutate(getBitListByIntArray(s_expansion_table, 48), m_R);

		for(int n = 0; n < m_R.size(); n++)
			m_R[n] = m_R[n] ^ m_Kn[iteration][n];
		int len = m_R.size();
		BitList B[8];
		for(int k = 0; k < 8; k++)
		{
			int begin = k*6;
			int end = begin + 6;
			if(end > len)
				end = len;
			B[k] = getBitListByBitList(m_R, begin, end);
		}

		int j = 0;
		BitList Bn;
		for(int k = 0; k < 32; k++)
			Bn.push_back(0);
		int pos = 0;
		while(j < 8)
		{
			int m = (B[j][0] << 1) + B[j][5];
			int n = (B[j][1] << 3) + (B[j][2] << 2) + (B[j][3] << 1) + B[j][4];
			int v = s_sbox[j][((m << 4) + n)];

			Bn[pos] = (v & 8) >> 3;
			Bn[pos + 1] = (v & 4) >> 2;
			Bn[pos + 2] = (v & 2) >> 1;
			Bn[pos + 3] = v & 1;

			pos += 4;
			j++;
		}

		m_R = _permutate(getBitListByIntArray(s_p, 32), Bn);
		for(int n = 0; n < m_R.size(); n++)
			m_R[n] = m_R[n] ^ m_L[n];

		m_L = tmpR;

		i++;
		iteration += iteration_adjustment;
	}
	m_final = _permutate(getBitListByIntArray(s_fp, 64), bitListAddBitList(m_R, m_L));
	return m_final;
}

std::string DesEncrypt::crypt(std::string data, char cryptType)
{
	if(data.empty())
		return "";
	if(0 != (data.length()%m_blockSize))
	{
		if(s_DECRYPT == cryptType)
			throw "Invalid data length, data must be a multiple of 8 bytes\n.";
		if(getPadding().empty())
			throw "Invalid data length, data must be a multiple of 8 bytes\n. Try setting the optional padding character";
		else
			data = strAppendstrTimes(data, getPadding(), (m_blockSize - (data.length()%m_blockSize)));
	}

	BitList iv;
	if(CBC == getMode())
	{
		if(!getIV().empty())
			iv = _String_to_BitList(getIV());
		else
			throw "For CBC mode, you must supply the Initial Value (IV) for ciphering";
	}

	int i = 0;
	std::string result;
	while(i < data.length())
	{
		BitList processed_block;
		BitList block = _String_to_BitList(data.substr(i, 8));
		if(CBC == getMode())
		{
			if(s_ENCRYPT == cryptType)
				for(int n = 0; n < block.size(); n++)
					block[n] = block[n] ^ iv[n];

			processed_block = _des_crypt(block, cryptType);
			if(s_DECRYPT == cryptType)
			{
				for(int n = 0; n < block.size(); n++)
					processed_block[n] = processed_block[n] ^ iv[n];
				iv = block;
			}
			else
			{
				iv = processed_block;
			}
		}
		else
		{
			processed_block = _des_crypt(block, cryptType);
		}
		result += _BitList_to_String(processed_block);
		i += 8;
	}

	return result;
}

std::string DesEncrypt::encrypt(std::string data)
{
	return encrypt(data, getPadding());
}

std::string DesEncrypt::encrypt(std::string data, std::string pad)
{
	return encrypt(data, pad, getPadMode());
}

std::string DesEncrypt::encrypt(std::string data, std::string pad, PaddingMode padMode)
{
	data = _guardAgainstUnicode(data);
	if(!pad.empty())
		pad = _guardAgainstUnicode(pad);
	data = _padData(data, pad, padMode);
	return crypt(data, s_ENCRYPT);
}

std::string DesEncrypt::decrypt(std::string data)
{
	return decrypt(data, getPadding());
}

std::string DesEncrypt::decrypt(std::string data, std::string pad)
{
	return decrypt(data, pad, getPadMode());
}

std::string DesEncrypt::decrypt(std::string data, std::string pad, PaddingMode padMode)
{
	data = _guardAgainstUnicode(data);
	if(!pad.empty())
		pad = _guardAgainstUnicode(pad);
	data = crypt(data, s_DECRYPT);
	return _unpadData(data, pad, padMode);
}


static int desEncry(lua_State* L)
{
	const char* Key = luaL_checkstring(L, 1);
	const char* In = luaL_checkstring(L, 2);
	const int size = luaL_checknumber(L, 3);
	DesEncrypt des = DesEncrypt(Key, DesEncrypt::CBC, Key, "", DesEncrypt::PAD_PHCS5);
	std::string result = des.encrypt(std::string(In,size));
	lua_pushlstring(L, result.c_str(), result.length());
	return 1;
}

static const struct luaL_reg _des[] = {
		{ "encrypt", desEncry },
		{ NULL, NULL }
};

LUALIB_API int luaopen_des(lua_State *L)
{
	luaL_register(L, "des", _des);
	return 1;
}