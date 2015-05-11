using System;
using UnityEngine;
using System.Collections.Generic;
using System.Text;
using System.Security.Cryptography;
using System.Threading;
namespace UniShare
{
	public enum PlatformType
	{
		PLATFORM_SINAWEIBO,
		PLATFORM_TENCENTWEIBO,
		PLATFORM_RENREN,
		PLATFORM_KAIXIN,
		PLATFORM_DOUBAN,
		PLATFORM_WEIXIN,
		PLATFROM_LEXUN,
		PLATFORM_FACEBOOK,
		PLATFORM_TWITTER,
		PLATFORM_LINKEDIN,
		PLATFORM_FOURSQUARE,
		PLATFORM_GOOGLEPLUS,
		PLATFORM_QZONE,
		PLATFORM_WITHOUTITLE
	}
     
	/// <summary>OAuth signature, aouth1.0 only </summary>
	public enum Signature
	{
		PLAINTEXT,
		RSASHA1,
		HMACSHA1
	}
  
	public enum OAuthVersion
	{
		VERSION_1,
		VERSION_2
	}
	/// <summary>
	/// asynchronously call delegate type
	/// </summary>
	/// <typeparam name="T">API return type</typeparam>
	/// <returns>T</returns>
	public delegate T AsyncInvokeDelegate<T> ();
	/// <summary>
	/// asynchronously call delegate
	/// </summary>
	/// <typeparam name="T">API return type</typeparam>
	/// <param name="result">AsyncCallback object</param>
	public delegate void AsyncCallbackDelegate<T> (AsyncCallback<T> result); 
	/// <summary>
	/// OAuth class, both version 1.0, 2.0 support
	/// </summary>
	public class OAuth
	{
		//新浪微博
		private const string BASE_URL_SINAWEIBO = "https://api.weibo.com/2/";
		private const string AUTHORIZE_URL_SINAWEIBO = "https://api.weibo.com/oauth2/authorize";
		private const string PLAYER_PREFS_ACCESSTOKEN_SINAWEIBO = "SinaWeiboAccessToken";
		private const string PLAYER_PREFS_EXPIRES_IN_SINAWEIBO = "SinaWeiboExpiresIn";
		//腾讯微博
		private const string BASE_URL_TENCENTWEIBO = "http://open.t.qq.com/api/";
		private const string AUTHORIZE_URL_TENCENTWEIBO = "http://openapi.qzone.qq.com/oauth/show";
		private const string PLAYER_PREFS_ACCESSTOKEN_TENCENTWEIBO = "TencentWeiboAccessToken";
		private const string PLAYER_PREFS_OPENID_TENCENTWEIBO = "TencentWeiboOpenID";
		private const string PLAYER_PREFS_OPENKEY_TENCENTWEIBO = "TencentWeiboOpenKey";
		private const string PLAYER_PREFS_EXPIRES_IN_TENCENTWEIBO = "TencentExpiresIn";
		//人人网
		private const string BASE_URL_RENREN = "https://api.renren.com/v2/";
		private const string AUTHORIZE_URL_RENREN = "https://graph.renren.com/oauth/authorize";     
		private const string PLAYER_PREFS_ACCESSTOKEN_RENREN = "RenrenAccessToken";
		private const string PLAYER_PREFS_EXPIRES_IN_RENREN = "RenrenExpiresIn";
		//开心网
		private const string BASE_URL_KAIXIN = "https://api.kaixin001.com/";
		private const string AUTHORIZE_URL_KAIXIN = "http://api.kaixin001.com/oauth2/authorize";        
		private const string PLAYER_PREFS_ACCESSTOKEN_KAIXIN = "KaixinAccessToken";
		private const string PLAYER_PREFS_EXPIRES_IN_KAIXIN = "KaixinkExpiresIn";
		//豆瓣
		private const string BASE_URL_DOUBAN = "https://api.douban.com/";
		private const string AUTHORIZE_URL_DOUBAN = "https://www.douban.com/service/auth2/auth";
		private const string PLAYER_PREFS_ACCESSTOKEN_DOUBAN = "DoubanAccessToken";
		private const string PLAYER_PREFS_EXPIRES_IN_DOUBAN = "DoubanExpiresIn";
		//微信
		private const string BASE_URL_WEIXIN = "https://api.weixin.qq.com/";
		private const string AUTHORIZE_URL_WEIXIN = "https://open.weixin.qq.com/oauth"; 
		private const string PLAYER_PREFS_ACCESSTOKEN_WEIXIN = "WeixinAccessToken";
		private const string PLAYER_PREFS_EXPIRES_IN_WEIXIN = "WeixinExpiresIn";
		//facebook
		private const string BASE_URL_FACEBOOK = "https://graph.facebook.com/";
		private const string AUTHORIZE_URL_FACEBOOK = "https://www.facebook.com/dialog/oauth";  
		private const string PLAYER_PREFS_ACCESSTOKEN_FACEBOOK = "FacebookAccessToken";
		private const string PLAYER_PREFS_EXPIRES_IN_FACEBOOK = "FacebookExpiresIn";
		//twitter
		private const string BASE_URL_TWITTER = "https://api.twitter.com/1.1/";
		private const string REQUEST_TOKEN_TWITTER = "https://api.twitter.com/oauth/request_token";
		private const string ACCESS_TOKEN_TWITTER = "https://api.twitter.com/oauth/access_token";
		private const string AUTHORIZE_URL_TWITTER = "https://twitter.com/oauth/authorize";     
		private const string PLAYER_PREFS_OAUTHTOKEN_TWITTER = "TwitterOauthToken";
		private const string PLAYER_PREFS_OAUTHTOKENSECRET_TWITTER = "TwitterOauthTokenSecret";
		//linkedin
		private const string BASE_URL_LINKEDIN = "http://api.linkedin.com/v1/";
		private const string REQUEST_TOKEN_LINKEDIN = "https://api.linkedin.com/uas/oauth/requestToken";
		private const string ACCESS_TOKEN_LINKEDIN = "https://api.linkedin.com/uas/oauth/accessToken";
		private const string AUTHORIZE_URL_LINKEDIN = "https://www.linkedin.com/uas/oauth/authenticate";        
		private const string PLAYER_PREFS_OAUTHTOKEN_LINKEDIN = "LinkedinOauthToken";
		private const string PLAYER_PREFS_OAUTHTOKENSECRET_LINKEDIN = "LinkedinOauthTokenSecret";   
		//Foursquare 
		private const string BASE_URL_FOURSQUARE = "https://api.foursquare.com/v2/";
		private const string AUTHORIZE_URL_FOURSQUARE = "https://foursquare.com/oauth2/authenticate";  
		private const string PLAYER_PREFS_ACCESSTOKEN_FOURSQUARE = "FoursquareAccessToken";
		private const string PLAYER_PREFS_EXPIRES_IN_FOURSQUARE = "FoursquareExpiresIn";
		//Googleplus 
		private const string BASE_URL_GOOGLEPLUS = "https://www.googleapis.com/plus/v1/";
		private const string AUTHORIZE_URL_GOOGLEPLUS = "https://accounts.google.com/o/oauth2/auth";  
		private const string PLAYER_PREFS_ACCESSTOKEN_GOOGLEPLUS = "GooglePlusAccessToken";
		private const string PLAYER_PREFS_EXPIRES_IN_GOOGLEPLUS = "GooglePlusExpiresIn";
		//QZone
		private const string BASE_URL_QZONE = "https://graph.qq.com/";
		private const string AUTHORIZE_URL_QZONE = "https://graph.qq.com/oauth2.0/authorize";
		//private const string AUTHORIZE_URL_QZONE = "https://graph.z.qq.com/moc2/authorize";  
		private const string PLAYER_PREFS_ACCESSTOKEN_QZONE = "QZoneAccessToken";
		private const string PLAYER_PREFS_OPENID_QZONE = "QZoneOpenID";
		private const string PLAYER_PREFS_EXPIRES_IN_QZONE = "QZoneExpiresIn";
		/// <summary>
		/// Platform
		/// </summary>
		public PlatformType Platform {
			get;
			internal set;
		}
         
		/// <summary>
		/// App Key
		/// </summary>
		public string AppKey {
			get;
			internal set;
		}
		/// <summary>
		/// App Secret
		/// </summary>
		public string AppSecret {
			get;
			internal set;
		}
         
		private string accessToken;
		/// <summary>
		/// Access Token
		/// </summary>
		public string AccessToken {
			get { return accessToken;}
			internal set {
				accessToken = value;
				//PlayerPrefs.SetString(PLAYER_PREFS_ACCESSTOKEN, accessToken);
			}
		}
		/// <summary>
		/// OAuth Version: 1.0, 2.0
		/// </summary>
		public OAuthVersion oauthVersion {
			get;
			internal set;
		}
		/// <summary>
		/// CallbackUrl
		/// </summary>
		public string CallbackUrl {
			get;
			set;
		}
		private System.DateTime expiresIn;
		public System.DateTime ExpiresIn {
			get {
				return expiresIn;
			}
			internal set {
				expiresIn = value;
//                PlayerPrefs.SetString(PLAYER_PREFS_EXPIRES_IN, expiresIn.ToString());
			}
		}
		/// <summary>
		/// Refresh Token, not used current
		/// </summary>
		public string RefreshToken {
			get;
			internal set;
		}
  
		/// <summary>
		/// BaseUrl of open platform
		/// </summary>
		public string BaseUrl {
			get;
			internal set;
		}       
  
		/// <summary>
		/// authorize url of open platform
		/// </summary>
		public string AuthorizeUrl {
			get;
			internal set;
		}
         
		/// <summary>
		/// RequestToken url of open platform
		/// </summary>
		public string RequestTokenUrl {
			get;
			internal set;
		}   
		/// <summary>
		/// AccessToken url of open platform
		/// </summary>        
		public string AccessTokenUrl {
			get;
			internal set;
		}       
		/// <summary>
		/// Signature type, oauth1.0 only
		/// </summary>        
		protected Signature SignatureType { get; set; }
         
         
		private string oauthToken;
		/// <summary>
		/// OAuthToken, oauth1.0 only
		/// </summary>        
		public string OAuthToken {
			get {
				return oauthToken;
			}
			set {
				oauthToken = value;
				//PlayerPrefs.SetString(PLAYER_PREFS_OAUTHTOKEN, oauthToken);
			}
		}
         
		private string oauthTokenSecret;
		/// <summary>
		/// OAuthTokenSecret, oauth1.0 only
		/// </summary>    
		public string OAuthTokenSecret {
			get {
				return oauthTokenSecret;
			} 
			set {
				oauthTokenSecret = value;
				//PlayerPrefs.SetString(PLAYER_PREFS_OAUTHTOKENSECRET, oauthTokenSecret);
			}
		}
         
		private string openID;
		private string openKey;
		/// <summary>
		/// OpenID, for tencent weibo only
		/// </summary>        
		public string OpenID {
			get {
				return openID;
			}
			set {
				openID = value;
				//PlayerPrefs.SetString(PLAYER_PREFS_OPENID_TENCENTWEIBO, openID);
			}
		}
		/// <summary>
		/// OpenKey, for tencent weibo only
		/// </summary>        
		public string OpenKey {
			get {
				return openKey;
			}
			set {
				openKey = value;
				//PlayerPrefs.SetString(PLAYER_PREFS_OPENKEY_TENCENTWEIBO, openKey);
			}
		}
		/// <summary>
		/// PlayPrefs name of accesstoken
		/// </summary>        
		public string PLAYER_PREFS_ACCESSTOKEN { get; set; }
		/// <summary>
		/// PlayPrefs name of openid
		/// </summary>        
		public string PLAYER_PREFS_OPENID { get; set; }
		/// <summary>
		/// PlayPrefs name of openkey, current tencentweibo only
		/// </summary>        
		public string PLAYER_PREFS_OPENKEY { get; set; }		
		
		/// <summary>
		/// PlayPrefs name of expired time of accesstoken
		/// </summary>        
		public string PLAYER_PREFS_EXPIRES_IN { get; set; }
		/// <summary>
		/// PlayPrefs name of oauthtoken, for oauth1.0
		/// </summary>
		public string PLAYER_PREFS_OAUTHTOKEN { get; set; }
		/// <summary>
		/// PlayPrefs name of oauthtokensecret, for oauth1.0
		/// </summary>
		public string PLAYER_PREFS_OAUTHTOKENSECRET { get; set; }
         
		private System.Random RandomGenerator { get; set; }
         
		/// <summary>
		/// OAuth construction function
		/// </summary>
		/// <param name="appKey">AppKey</param>
		/// <param name="appSecret">AppSecret</param>
		/// <param name="callbackUrl">callbackUrl, must be the same as you setting on the open platform website </param>
		public OAuth (PlatformType platformType, string appKey, string appSecret, string callbackUrl)
		{
			this.Platform = platformType;
			this.AppKey = appKey;
			this.AppSecret = appSecret;
			this.CallbackUrl = callbackUrl;
  
			switch (platformType) {
			case PlatformType.PLATFORM_DOUBAN:
				this.BaseUrl = BASE_URL_DOUBAN;
				this.AuthorizeUrl = AUTHORIZE_URL_DOUBAN;
				this.PLAYER_PREFS_ACCESSTOKEN = PLAYER_PREFS_ACCESSTOKEN_DOUBAN;
				this.PLAYER_PREFS_EXPIRES_IN = PLAYER_PREFS_EXPIRES_IN_DOUBAN;
				this.oauthVersion = OAuthVersion.VERSION_2;
				break;
			case PlatformType.PLATFORM_FACEBOOK:
				this.BaseUrl = BASE_URL_FACEBOOK;
				this.AuthorizeUrl = AUTHORIZE_URL_FACEBOOK;
				this.PLAYER_PREFS_ACCESSTOKEN = PLAYER_PREFS_ACCESSTOKEN_FACEBOOK;
				this.PLAYER_PREFS_EXPIRES_IN = PLAYER_PREFS_EXPIRES_IN_FACEBOOK;
				this.oauthVersion = OAuthVersion.VERSION_2;
				break;
			case PlatformType.PLATFORM_KAIXIN:
				this.BaseUrl = BASE_URL_KAIXIN;
				this.AuthorizeUrl = AUTHORIZE_URL_KAIXIN;
				this.PLAYER_PREFS_ACCESSTOKEN = PLAYER_PREFS_ACCESSTOKEN_KAIXIN;
				this.PLAYER_PREFS_EXPIRES_IN = PLAYER_PREFS_EXPIRES_IN_KAIXIN;
				this.oauthVersion = OAuthVersion.VERSION_2;             
				break;
			case PlatformType.PLATFORM_RENREN:
				this.BaseUrl = BASE_URL_RENREN;
				this.AuthorizeUrl = AUTHORIZE_URL_RENREN;
				this.PLAYER_PREFS_ACCESSTOKEN = PLAYER_PREFS_ACCESSTOKEN_RENREN;
				this.PLAYER_PREFS_EXPIRES_IN = PLAYER_PREFS_EXPIRES_IN_RENREN;
				this.oauthVersion = OAuthVersion.VERSION_2;             
				break;
			case PlatformType.PLATFORM_SINAWEIBO:
				this.BaseUrl = BASE_URL_SINAWEIBO;
				this.AuthorizeUrl = AUTHORIZE_URL_SINAWEIBO;
				this.PLAYER_PREFS_ACCESSTOKEN = PLAYER_PREFS_ACCESSTOKEN_SINAWEIBO;
				this.PLAYER_PREFS_EXPIRES_IN = PLAYER_PREFS_EXPIRES_IN_SINAWEIBO;
				this.oauthVersion = OAuthVersion.VERSION_2;             
				break;
			case PlatformType.PLATFORM_TENCENTWEIBO:
				this.BaseUrl = BASE_URL_TENCENTWEIBO;
				this.AuthorizeUrl = AUTHORIZE_URL_TENCENTWEIBO;
				this.PLAYER_PREFS_ACCESSTOKEN = PLAYER_PREFS_ACCESSTOKEN_TENCENTWEIBO;
				this.PLAYER_PREFS_EXPIRES_IN = PLAYER_PREFS_EXPIRES_IN_TENCENTWEIBO;
				this.oauthVersion = OAuthVersion.VERSION_2;
				this.PLAYER_PREFS_OPENID = PLAYER_PREFS_OPENID_TENCENTWEIBO;
				this.PLAYER_PREFS_OPENKEY = PLAYER_PREFS_OPENKEY_TENCENTWEIBO;
				openID = PlayerPrefs.GetString (this.PLAYER_PREFS_OPENID);
				openKey = PlayerPrefs.GetString (PLAYER_PREFS_OPENKEY_TENCENTWEIBO);
				break;
			case PlatformType.PLATFORM_TWITTER:
				this.BaseUrl = BASE_URL_TWITTER;
				this.AuthorizeUrl = AUTHORIZE_URL_TWITTER;
				this.RequestTokenUrl = REQUEST_TOKEN_TWITTER;
				this.AccessTokenUrl = ACCESS_TOKEN_TWITTER;
				this.SignatureType = Signature.HMACSHA1;
				this.PLAYER_PREFS_OAUTHTOKEN = PLAYER_PREFS_OAUTHTOKEN_TWITTER;
				this.PLAYER_PREFS_OAUTHTOKENSECRET = PLAYER_PREFS_OAUTHTOKENSECRET_TWITTER;
				this.oauthVersion = OAuthVersion.VERSION_1;
				break;
			case PlatformType.PLATFORM_WEIXIN:
				this.BaseUrl = BASE_URL_WEIXIN;
				this.AuthorizeUrl = AUTHORIZE_URL_WEIXIN;
				this.PLAYER_PREFS_ACCESSTOKEN = PLAYER_PREFS_ACCESSTOKEN_WEIXIN;
				this.PLAYER_PREFS_EXPIRES_IN = PLAYER_PREFS_EXPIRES_IN_WEIXIN;
				this.oauthVersion = OAuthVersion.VERSION_2;             
				break;
			case PlatformType.PLATFORM_LINKEDIN:
				this.BaseUrl = BASE_URL_LINKEDIN;
				this.AuthorizeUrl = AUTHORIZE_URL_LINKEDIN;
				this.RequestTokenUrl = REQUEST_TOKEN_LINKEDIN;
				this.AccessTokenUrl = ACCESS_TOKEN_LINKEDIN;
				this.SignatureType = Signature.HMACSHA1;
				this.PLAYER_PREFS_OAUTHTOKEN = PLAYER_PREFS_OAUTHTOKEN_LINKEDIN;
				this.PLAYER_PREFS_OAUTHTOKENSECRET = PLAYER_PREFS_OAUTHTOKENSECRET_LINKEDIN;
				this.oauthVersion = OAuthVersion.VERSION_1;
				break;              
			case PlatformType.PLATFORM_FOURSQUARE:
				this.BaseUrl = BASE_URL_FOURSQUARE;
				this.AuthorizeUrl = AUTHORIZE_URL_FOURSQUARE;
				this.PLAYER_PREFS_ACCESSTOKEN = PLAYER_PREFS_ACCESSTOKEN_FOURSQUARE;
				this.PLAYER_PREFS_EXPIRES_IN = PLAYER_PREFS_EXPIRES_IN_FOURSQUARE;
				this.oauthVersion = OAuthVersion.VERSION_2;
				break;
			case PlatformType.PLATFORM_GOOGLEPLUS:
				this.BaseUrl = BASE_URL_GOOGLEPLUS;
				this.AuthorizeUrl = AUTHORIZE_URL_GOOGLEPLUS;
				this.PLAYER_PREFS_ACCESSTOKEN = PLAYER_PREFS_ACCESSTOKEN_GOOGLEPLUS;
				this.PLAYER_PREFS_EXPIRES_IN = PLAYER_PREFS_EXPIRES_IN_GOOGLEPLUS;
				this.oauthVersion = OAuthVersion.VERSION_2;
				break;		
			case PlatformType.PLATFORM_QZONE:
				this.BaseUrl = BASE_URL_QZONE;
				this.AuthorizeUrl = AUTHORIZE_URL_QZONE;
				this.PLAYER_PREFS_ACCESSTOKEN = PLAYER_PREFS_ACCESSTOKEN_QZONE;
				this.PLAYER_PREFS_OPENID = PLAYER_PREFS_OPENID_QZONE;
				openID = PlayerPrefs.GetString (this.PLAYER_PREFS_OPENID);
				this.PLAYER_PREFS_EXPIRES_IN = PLAYER_PREFS_EXPIRES_IN_QZONE;
				this.oauthVersion = OAuthVersion.VERSION_2;
				break;
			default:
				this.BaseUrl = "";
				this.AuthorizeUrl = "";
				this.oauthVersion = OAuthVersion.VERSION_2;
				break;
			}           
			if (this.oauthVersion == OAuthVersion.VERSION_1) {
				oauthToken = PlayerPrefs.GetString (this.PLAYER_PREFS_OAUTHTOKEN);
				oauthTokenSecret = PlayerPrefs.GetString (this.PLAYER_PREFS_OAUTHTOKENSECRET);
			} else {
				accessToken = PlayerPrefs.GetString (this.PLAYER_PREFS_ACCESSTOKEN);
				if (PlayerPrefs.HasKey (this.PLAYER_PREFS_EXPIRES_IN)) {
					string strExpiresIn = PlayerPrefs.GetString (this.PLAYER_PREFS_EXPIRES_IN);
					if (string.IsNullOrEmpty (strExpiresIn)) {
						this.expiresIn = new DateTime (1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
					} else {
						this.expiresIn = System.Convert.ToDateTime (strExpiresIn); 
					}
				}
			}
			RandomGenerator = new System.Random ();
			
			//Debug.Log("Openid in OAuth = " + openID);
		}
         
		/// <summary>
		/// Save PlayerPrefers for oauth 1.0
		/// </summary>
		public void SavePlayerPrefers ()
		{
			PlayerPrefs.SetString (PLAYER_PREFS_OAUTHTOKEN, oauthToken);
			PlayerPrefs.SetString (PLAYER_PREFS_OAUTHTOKENSECRET, oauthTokenSecret);
			PlayerPrefs.SetString (PLAYER_PREFS_ACCESSTOKEN, accessToken);
			PlayerPrefs.SetString (PLAYER_PREFS_EXPIRES_IN, expiresIn.ToString ());
			if (!string.IsNullOrEmpty (PLAYER_PREFS_OPENID)) {
				PlayerPrefs.SetString (PLAYER_PREFS_OPENID, openID);
			}
			
			if (!string.IsNullOrEmpty (PLAYER_PREFS_OPENKEY)) {
				PlayerPrefs.SetString (PLAYER_PREFS_OPENKEY, openKey);
			}

			PlayerPrefs.Save ();
		}
         
		/// <summary>
		/// Custom request api for linkedin only
		/// </summary>
		/// <param name="url">request url</param>
		/// <param name="method">RequestMethod get/post </param>
		/// <param name="data"> request data </param> 
		internal string Request (string url, RequestMethod method, string data)
		{
			Request r = null;
			//string rawUrl = string.Empty;
			UriBuilder uri = new UriBuilder (url);
             
			string result = string.Empty;
  
			switch (method) {
			case RequestMethod.Get:
				{
					r = new Request ("get", url);
				}
				break;
			case RequestMethod.Post:
				{
					r = new Request ("post", uri.Uri);
				}
				break;
			}
  
			r.SetHeader ("User-Agent", "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0)");
			r.AddHeader ("Connection", "keep-alive");
			
			switch (method) {
			case RequestMethod.Get:
				{
					//http.Method = "GET";
					if (this.Platform == PlatformType.PLATFORM_LINKEDIN) {

					} else if (this.Platform == PlatformType.PLATFORM_GOOGLEPLUS) {
						string head = string.Format ("OAuth {0}", this.accessToken);
						r.AddHeader ("Authorization", head);
						r.AddHeader ("Content-Length", "0");
					}				
				}
				break;
			case RequestMethod.Post:
				{
					if (this.Platform == PlatformType.PLATFORM_LINKEDIN) {
						string head = GetAuthorizeHead (url, method);
						r.AddHeader ("Authorization", head); 
						r.AddHeader ("Content-Type", "application/json");
						r.AddHeader ("x-li-format", "json");
							
						r.bytes = System.Text.Encoding.UTF8.GetBytes (data);
						r.AddHeader ("Content-Length", r.bytes.Length.ToString ());
					} else if (this.Platform == PlatformType.PLATFORM_GOOGLEPLUS) {
						string head = string.Format ("OAuth {0}", this.accessToken);
						r.AddHeader ("Authorization", head); 
						r.AddHeader ("Content-Type", "application/json");
						r.AddHeader ("x-li-format", "json");
						r.bytes = System.Text.Encoding.UTF8.GetBytes (data);
						r.AddHeader ("Content-Length", r.bytes.Length.ToString ());
					}
				}
				break;
			}

             
			result = r.Send ();
			return result;          
		}
		/// <summary>
		/// request api
		/// </summary>        
		/// <param name="url">request url</param>
		/// <param name="method">RequestMethod get/post </param>
		/// <param name="parameters"> parameters for request </param>
		internal string Request (string url, RequestMethod method, params HttpParameter[] parameters)
		{
			Request r = null;
  
			//string rawUrl = string.Empty;
			UriBuilder uri = new UriBuilder (url);
             
			string result = string.Empty;
			bool multi = false;
			foreach (var item in parameters) {
				if (item.IsBinaryData) {
					multi = true;
					break;
				}
			}
  
			switch (method) {
			case RequestMethod.Get:
				{
					uri.Query = Utility.BuildQueryString (parameters);
					if (this.oauthVersion == OAuthVersion.VERSION_1) {
						r = new Request ("get", url);
					} else {
						r = new Request ("get", uri.Uri);
					}
				}
				break;
			case RequestMethod.Post:
				{
					if (!multi) {
						uri.Query = Utility.BuildQueryString (parameters);
					}
					r = new Request ("post", uri.Uri);
				}
				break;
			}
  
			r.SetHeader ("User-Agent", "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0)");
			r.AddHeader ("Connection", "keep-alive");
			//r.AddHeader("Content-Type", "application/x-www-form-urlencoded");
			if (this.oauthVersion == OAuthVersion.VERSION_1) {
				string head;
				if (multi) {
					//r.AddHeader("Accept-Encoding", "gzip");
                     
					head = GetAuthorizeHead (url, method);
				} else {
					head = GetAuthorizeHead (url, method, parameters);
				}
				r.AddHeader ("Authorization", head);         
			}
			switch (method) {
			case RequestMethod.Get:
				{
					//http.Method = "GET";
				}
				break;
			case RequestMethod.Post:
				{
					if (multi) {
						string boundary = Utility.GetBoundary ();
						r.AddHeader ("Content-Type", string.Format ("multipart/form-data; boundary={0}", boundary));
						r.bytes = Utility.BuildPostData (boundary, parameters);
						r.AddHeader ("Content-Length", r.bytes.Length.ToString ());
                            
					} else {
						r.AddHeader ("Content-Type", "application/x-www-form-urlencoded");
						//r.AddHeader("Content-Length", uri.Uri.Query.Length.ToString());
						Debug.Log ("BuildQueryString:" + Utility.BuildQueryString (parameters));
						r.bytes = System.Text.Encoding.UTF8.GetBytes (Utility.BuildQueryString (parameters));
						r.AddHeader ("Content-Length", r.bytes.Length.ToString ());
					}
				}
				break;
			}
			result = r.Send ();
			return result;
		}
             
         
		private string GetAuthorizeHead (string url, RequestMethod method, params HttpParameter[] parameters)
		{
			string SignatureMethod = "";
			if (this.SignatureType == Signature.HMACSHA1)
				SignatureMethod = "HMAC-SHA1";
			else if (this.SignatureType == Signature.RSASHA1)
				SignatureMethod = "RSA-SHA1";
			else if (this.SignatureType == Signature.PLAINTEXT)
				SignatureMethod = "PLAINTEXT";
			var epochStart = new System.DateTime (1970, 1, 1, 0, 0, 0, System.DateTimeKind.Utc);
			string timestamp = Convert.ToInt64 ((System.DateTime.UtcNow - epochStart).TotalSeconds).ToString ();
			//string timestamp = Convert.ToInt64((System.DateTime.Now - epochStart).TotalSeconds).ToString();
			List<HttpParameter> paras = new List<HttpParameter> ()
            {
                new HttpParameter("oauth_consumer_key", this.AppKey),
                new HttpParameter("oauth_nonce", RandomGenerator.Next(123400, 9999999).ToString()),
                new HttpParameter("oauth_signature_method", SignatureMethod),
                new HttpParameter("oauth_timestamp", timestamp),
                new HttpParameter("oauth_version", "1.0"),
            };
             
  
             
			if (!string.IsNullOrEmpty (this.OAuthToken))
				paras.Add (new HttpParameter ("oauth_token", this.OAuthToken));
			if (!string.IsNullOrEmpty (this.OAuthTokenSecret))
				paras.Add (new HttpParameter ("oauth_token_secret", this.OAuthTokenSecret));
  
                 
			StringBuilder sbList = new StringBuilder ();
			StringBuilder headList = new StringBuilder ();
			string Splitter = "";
			string headSplitter = "";
			foreach (HttpParameter para in paras) {
				headList.AppendFormat ("{0}{1}=\"{2}\"", headSplitter, para.Name, para.Value);
				headSplitter = ",";
			}
  
			foreach (var item in parameters) {
				paras.Add (new HttpParameter (item.Name, Uri.EscapeDataString (item.Value.ToString ())));
				//paras.Add(new HttpParameter(item.Name, item.Value));
			}
			paras.Sort (new HttpParameterComparer ());
			foreach (HttpParameter para in paras) {
				sbList.AppendFormat ("{0}{1}={2}", Splitter, para.Name, para.Value);
				Splitter = "&";
			}           
			string strParameter = sbList.ToString ();
			string strMethond = "GET";
			if (method == RequestMethod.Get)
				strMethond = "GET";
			else if (method == RequestMethod.Post)
				strMethond = "POST";
			Debug.Log ("before encode strParameter = " + strParameter);
			string baseString = strMethond + "&" + Uri.EscapeDataString (url) + "&" + Utility.UrlEncode (strParameter);
			Debug.Log ("baseString = " + baseString);    
             
			HMACSHA1 SHA1 = new HMACSHA1 ();
			SHA1.Key = Encoding.ASCII.GetBytes (this.AppSecret + "&" + (string.IsNullOrEmpty (this.OAuthTokenSecret) ? "" : Uri.EscapeDataString (this.OAuthTokenSecret)));               
			string signature = Utility.UrlEncode (Convert.ToBase64String (SHA1.ComputeHash (System.Text.Encoding.ASCII.GetBytes (baseString)))); 
			//string signature = Uri.EscapeDataString(Convert.ToBase64String(SHA1.ComputeHash(System.Text.Encoding.UTF8.GetBytes(baseString)))); 
			string headString = headList.ToString ();
			
			//headString = "OAuth " + headString;
			headString = "OAuth " + headString + string.Format (",oauth_signature=\"{0}\"", signature);
			return headString;          
		}
         
		/// <summary>
		/// check if accesstoken expired
		/// </summary>    
		/// <returns>return true if accesstoken not expireed</returns>
		public bool VerifierAccessToken ()
		{
			if (oauthVersion == OAuthVersion.VERSION_1) {
				if (string.IsNullOrEmpty (this.OAuthToken) || string.IsNullOrEmpty (this.OAuthTokenSecret))
					return false;
			} else if (oauthVersion == OAuthVersion.VERSION_2) {
				if (string.IsNullOrEmpty (this.AccessToken)) {
					return false;
				}
				//foursquare access tokens do not expire
				if (this.Platform == PlatformType.PLATFORM_FOURSQUARE) {
					return true;
				}
				return (DateTime.Compare (expiresIn, DateTime.Now) >= 0);
			}
			return true;
		}
         
		/// <summary>
		/// AsyncInvoke in another thread
		/// </summary>            
		/// <param name="invoker">invoker delegate</param>
		/// <param name="callback">callback delegate </param>
		public void AsyncInvoke<T> (AsyncInvokeDelegate<T> invoker, AsyncCallbackDelegate<T> callback)
		{
			ThreadPool.QueueUserWorkItem (new WaitCallback (delegate(object state) {
				AsyncCallback<T> result;
				try {
					T invoke = invoker ();
					result = new AsyncCallback<T> (invoke);
					callback (result);
  
				} catch (Exception ex) {
					result = new AsyncCallback<T> (ex, false);
					callback (result);
				}
  
			}));
  
		}
		
		public void ResetToken ()
		{
			this.AccessToken = "";
			if (this.oauthVersion == OAuthVersion.VERSION_1) {
				this.OAuthToken = "";
				this.OAuthTokenSecret = "";
			}
			
			this.expiresIn = new DateTime (1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
		}
	}
}
