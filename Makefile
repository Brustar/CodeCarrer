#http://cs.baylor.edu/~donahoo/practical/CSockets2/textcode.html
SOURCES = $(wildcard *.c)
OBJS = $(SOURCES:.c=.o)
CFLAGS = -Wall -g

all : $(OBJS)
	
$(OBJS) : %.o : %.c
	$(CC) -c $(CFLAGS) $< -o $@

reg : reg.o
	cc $< -o $@

TestSizes : TestSizes.o
	cc $< -o $@
	./$@

GetAddrInfo : GetAddrInfo.o DieWithMessage.o AddressUtility.o
	cc $? -o $@

TCPEchoClient : TCPEchoClient.o DieWithMessage.o TCPClientUtility.o
	cc $? -o $@

TCPEchoServer : TCPEchoServer.o DieWithMessage.o TCPClientUtility.o TCPServerUtility.o AddressUtility.o
	cc $? -o $@

TCPEchoClient4 : TCPEchoClient4.o DieWithMessage.o TCPClientUtility.o
	cc $? -o $@

TCPEchoServer4 : TCPEchoServer4.o DieWithMessage.o TCPClientUtility.o TCPServerUtility.o AddressUtility.o
	cc $? -o $@

TCPEchoServer6 : TCPEchoServer6.o DieWithMessage.o TCPClientUtility.o TCPServerUtility.o AddressUtility.o
	cc $? -o $@

TCPEchoServer-Fork : TCPEchoServer-Fork.o DieWithMessage.o TCPClientUtility.o TCPServerUtility.o AddressUtility.o
	cc $? -o $@

TCPEchoServer-ForkN : TCPEchoServer-ForkN.o DieWithMessage.o TCPClientUtility.o TCPServerUtility.o AddressUtility.o
	cc $? -o $@

TCPEchoServer-select : TCPEchoServer-select.o DieWithMessage.o TCPClientUtility.o TCPServerUtility.o AddressUtility.o
	cc $? -o $@

TCPEchoServer-Thread : TCPEchoServer-Thread.o DieWithMessage.o TCPClientUtility.o TCPServerUtility.o AddressUtility.o
	cc $? -o $@

UDPEchoClient-Timeout : UDPEchoClient-Timeout.o DieWithMessage.o TCPClientUtility.o TCPServerUtility.o AddressUtility.o
	cc $? -o $@

UDPEchoServer-SIGIO : UDPEchoServer-SIGIO.o DieWithMessage.o TCPClientUtility.o TCPServerUtility.o AddressUtility.o
	cc $? -o $@

VoteClientTCP : VoteClientTCP.o LengthFramer.o DieWithMessage.o TCPClientUtility.o VoteEncodingText.o
	cc $? -o $@

VoteServerTCP : VoteServerTCP.o LengthFramer.o DieWithMessage.o TCPServerUtility.o VoteEncodingText.o AddressUtility.o
	cc $? -o $@

PlusOneClient : PlusOneClient.o DieWithMessage.o PracticalSocket.o
	c++ $? -o $@

PlusOneServer : PlusOneServer.o DieWithMessage.o PracticalSocket.o
	c++ $? -o $@

SurveyClient : SurveyClient.o SurveyCommon.o PracticalSocket.o
	c++ $? -o $@

SurveyServer : SurveyServer.o SurveyCommon.o PracticalSocket.o
	c++ $? -o $@

SurveyClient2 : SurveyClient2.o SurveyCommon.o PracticalSocket.o
	c++ $? -o $@

SurveyServer2 : SurveyServer2.o SurveyCommon.o PracticalSocket.o
	c++ $? -o $@

.PHONY : clean

clean :
	-rm *.o GetAddrInfo PlusOneClient reg TestSizes
