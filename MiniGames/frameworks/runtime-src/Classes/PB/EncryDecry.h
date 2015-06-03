#ifndef _ENCRY_DECRY_H_
#define _ENCRY_DECRY_H_

#ifndef byte
typedef unsigned char byte;
#endif
typedef unsigned char       BYTE;
typedef unsigned short      WORD;

//网络内核
typedef struct TCP_Info
{
	BYTE							cbDataKind;							//数据类型
	BYTE							cbCheckCode;						//效验字段
	WORD							wPacketSize;						//数据大小
	WORD                            wMsgID;                             //消息应答ID
}info;

//网络命令
typedef struct TCP_Command
{
	WORD							wMainCmdID;							//主命令码
	WORD							wSubCmdID;							//子命令码
}command;

//网络包头
typedef struct TCP_Head
{
	info						TCPInfo;							//基础结构
	command						CommandInfo;						//命令信息
}head;

char mapsendvbyte(byte data);
char maprecvbyte(byte data);
int encryBuffer(byte* data, int dataSize);
int decryptBuffer(byte* data, int start, int dataSize);
byte getciphermode();
int getMainCommand(byte* data, int start);
int getSubConmmand(byte* data, int start);
int getPackSize(byte* data, int start);
int setPackSize(byte* data, int dataSize);
int getMsgID(byte* data, int start);
void setPackInfo(byte* data, int dataSize, int nMsgID, int main, int sub);
int getCipher(byte* dataBuffer, int start);
int getCipherCode(byte* dataBuffer, int start);

///////////////////////////////MD5//////////////////////////////////////////
#define LEN_MD5						33									//加密密码
//长度定义
#define SOCKET_TCP_BUFFER			16384								//网络缓冲
#define HEADER_SIZE					sizeof(head)

//////////////////////////////////////////////////////////////////////////

#endif

