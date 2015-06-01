#import <UIKit/UIKit.h>
#import "AlixLibService.h"
#import "DataSigner.h"
#import "DataVerifier.h"
#import "AlixPayOrder.h"
#import "AlixPayResult.h"
#import "DialogUtil.h"

//商户私钥，自助生成
#define PartnerPrivKey @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBANwiS5F6gtdU9EYRuSXnX5gIC719YqTd8ODdyl+NbrH6lmxTSeUnGrXONKgbszRDWMST8XVz0FABbmo94l9GXM+LpXInuYA6FCUhGDqnjwFS9xpkQgB6jF3yWDXcoLhOI4FHKX0nvFARtDHNf+Sj/k0mgj+KB0/2T0Q3CHMy35IlAgMBAAECgYEAkKis1jYW42B9gcpFzEXGyQaIiIZsG4GJuIunYLF1i9nrndYB2mefItgWPF6vnemf3NaHtzJbMygtof121DtN4xF/9BsBfK8Ven8xJFYANUc5Jo1t6jt/CaL6mAgCyHou28L1H0ke35u5a5Pd+cbiwvm7oL7cEZgfXKqZ4QlCAcECQQDzCaIBKxEVriX2JUtXFt9npFileA4VDTexRCVKee6v/RWlqRX9eA3mUnYLGxFncqXNbL7P7+uxEhtX5CEYlPHVAkEA59/xNOoDQ1G/TIxBzrWiwHgCt9li0rhhMO0yA/X1c2EeuDiZ6lv7xj2XOvmikOWXNmDFkGlcIDBVURz82Yv3EQJBAINReiKtdX7EaSiVwB6fcjja+Tb3JozDZos2qfuS5KBc3Fx1fzdEriX7+mJHzuCZdvMHRhauqSg1A2c7EZLpr70CQCZrgcD9wVqnMeZSGxlQGU6A1Bp4Z5p4uInt02q6l1ft0LQ/lKkzYo1faS55bIlLsXluIW4jNwOSXqCZCABX47ECQBn3DoUAF3wGp68JElAJNYaNGkw+9ryOTddkMsZnJOBNjCsU62c0i5tO+6YkYuRc2RXHFcQnkJJhAHjv/Nx13sE="

//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

#define PARTNER @"2088301819527033"
#define SELLER  @"zhujianwu@lxyes.cn"
#define SCHEMES @"wxdf033a8f15d37124"

@interface AlipayRSA : NSObject

@property (nonatomic, assign)int scriptHandler;
	
- (void)payAction:(NSString *)tradeNO withID:(int)userid withPrice:(int)price;
+ (void) callAlipay:(NSDictionary*) dict;

@end