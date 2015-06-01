#import "AliPayRSA.h"

@implementation AlipayRSA

//wap回调函数
-(void)paymentResult:(NSString *)resultd
{
    //结果处理
#if ! __has_feature(objc_arc)
    AlixPayResult* result = [[[AlixPayResult alloc] initWithString:resultd] autorelease];
#else
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
#endif
	if (result)
    {
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
			if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                //验证签名成功，交易结果无篡改
                NSLog(@"验证签名成功");
                //[self resultLuaCallBack:@"success" Data:result.resultString];
			}
            else
            {
                //验证签名失败，交易结果被篡改
                NSLog(@"验证签名失败");
                [DialogUtil alert:@"验证签名失败" title:@"乐讯"];
            }
        }
        else
        {
            //交易失败
            NSLog(@"验证签名失败");
            [DialogUtil alert:@"验证签名失败" title:@"乐讯"];
        }
    }
    else
    {
        //失败
        NSLog(@"充值失败");
        [DialogUtil alert:@"充值失败" title:@"乐讯"];
    }
}

- (void)payAction:(NSString *)orderString
{
    //获取快捷支付单例并调用快捷支付接口
    [AlixLibService payOrder:orderString AndScheme:SCHEMES seletor:@selector(paymentResult:) target:self];
}

- (void)payAction:(NSString *)tradeNO withID:(int)userid withPrice:(int)price
{
    NSString* orderInfo = [self getOrderInfo:tradeNO withID:userid withPrice:price];
    NSString* signedStr = [self doRsa:orderInfo];
    
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderInfo, signedStr, @"RSA"];
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]]){
        [AlixLibService payOrder:orderString AndScheme:SCHEMES seletor:@selector(paymentResult:) target:self];
    }else{
        [DialogUtil alert:@"请安装支付宝" title:@"乐讯"];
    }
    
}

-(NSString*)getOrderInfo:(NSString *)tradeNO withID:(int)userid withPrice:(int)price
{
    /*
	 *点击获取prodcut实例并初始化订单信息
	 */
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PARTNER;
    order.seller = SELLER;
    
    order.tradeNO = tradeNO;
	order.productName = [NSString stringWithFormat:@"乐讯账户ID:%d",userid];
	order.productDescription = @"pay";
	order.amount = [NSString stringWithFormat:@"%d",price]; //商品价格
	order.notifyURL =  @"http%3A%2F%2Fcz.lexun.com/alipayclient/notify_url.aspx"; //回调URL
	
	return [order description];
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

+ (void) callAlipay:(NSDictionary*) dict
{
    NSString* tradeNO=[dict objectForKey:@"tradeNO"];
    int userid=[[dict objectForKey:@"userid"] intValue];
    int price=[[dict objectForKey:@"price"] intValue];
    AlipayRSA *pay=[[AlipayRSA alloc] init];
    [pay payAction:tradeNO withID:userid withPrice:price];
}

@end