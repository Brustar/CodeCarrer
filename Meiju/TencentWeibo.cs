using UnityEngine;
using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using UniShare;
using UniShare.Json;

/// <summary> 
/// TencentWeibo singleton class.
/// <para> mainpage: http://t.qq.com/ </para>
/// <para> open platform: http://dev.t.qq.com/ </para>
/// <para> Implemented API: "t/add", "t/add_pic", "t/add_pic_url" </para>
/// </summary> 
public class TencentWeibo : OpenPlatformBase
{

	private static TencentWeibo s_instance = null;
	public readonly string T_ADD = "t/add";
	public readonly string T_ADD_PIC = "t/add_pic";
	public readonly string T_ADD_PIC_URL = "t/add_pic_url";

	public delegate void dgThirdLogin (int type,string uid);
	public dgThirdLogin evtThirdLoginByTencent;

	void Init ()
	{
		if (isInited)
			return;
		InitWithPlatform (PlatformType.PLATFORM_TENCENTWEIBO, "tencentweibo");
		isInited = true;
	}

	public static TencentWeibo instance {
		get {
			if (s_instance == null) {
				s_instance = FindObjectOfType (typeof(TencentWeibo)) as TencentWeibo;
				if (s_instance != null)
					s_instance.Init ();
			}
			
			if (s_instance == null) {
				GameObject obj = new GameObject ("TencentWeibo");
				s_instance = obj.AddComponent (typeof(TencentWeibo)) as TencentWeibo;
				s_instance.Init ();
				Debug.Log ("Could not locate an TencentWeibo object. TencentWeibo was Generated Automaticly");
			}
			return s_instance;
		}
	}
	
	protected void OnApplicationQuit ()
	{
		if (oauth != null) {
			oauth.SavePlayerPrefers ();
		}
		s_instance = null;
		
	}
	void OnApplicationPause ()
	{
		if (oauth != null) {
			oauth.SavePlayerPrefers ();
		}
		s_instance = null;
	}	
	void OnDestroy ()
	{
		if (oauth != null) {
			oauth.SavePlayerPrefers ();
		}
		s_instance = null;
	}
	
	public override void Authorize ()
	{
		Logout ();
#if UNITY_EDITOR || UNITY_STANDALONE_OSX || UNITY_STANDALONE_WIN
		fullAuthorizeUrl = string.Format ("{0}?client_id={1}&redirect_uri={2}&response_type=token", oauth.AuthorizeUrl, oauth.AppKey, callbackUrl);
#elif UNITY_IPHONE||UNITY_ANDROID
		fullAuthorizeUrl = string.Format("{0}?client_id={1}&redirect_uri={2}&response_type=token&wap=2&which=login&display=mobile", oauth.AuthorizeUrl, oauth.AppKey, callbackUrl);
#endif
		base.Authorize ();
	}
	
	public override void AuthCallback (string result)
	{
		Debug.Log ("tencent weibo : \n" + result);
		//access_token=ACCESS_TOKEN&expires_in=60&openid=OPENID&openkey=OPENKEY	
		if (result == "UserCancel" || string.IsNullOrEmpty (result)) {
			OnAuthorizingResult (false);
			return;
		}
		string[] keypairs = result.Split ('&');
		if (keypairs.Length >= 4) {
			//save params
			string[] tokenItem = keypairs [0].Split ('=');
			oauth.AccessToken = tokenItem [1];
			
			string[] expireInItem = keypairs [1].Split ('=');
			oauth.ExpiresIn = System.DateTime.Now.AddSeconds (System.Convert.ToDouble (expireInItem [1]));
			
			string[] openIDItem = keypairs [2].Split ('=');
			oauth.OpenID = openIDItem [1];
			
			string[] openKeyItem = keypairs [3].Split ('=');
			oauth.OpenKey = openKeyItem [1];
			OnAuthorizingResult (true);

			evtThirdLoginByTencent (2, oauth.OpenID);
		} else {
			OnAuthorizingResult (false);
		}
	}
	/// <summary>
	/// post a status 
	/// </summary>
	/// <param name="txt">content of status, less than 140 characters </param>
	/// <returns></returns>
	public override void Share (string txt)
	{
		Share (txt, 0, 0);
	}

	/// <summary>
	/// post a status with location info 
	/// </summary>
	/// <param name="txt">content of the status, less than 140 characters.</param>
	/// <param name="lat">latitude from -90.0 to 90.0 default is 0.0</param>
	/// <param name="log">longitude from -180.0 to 180.0, default is 0.0 </param>
	/// <returns>void</returns>
	public void Share (string txt, float lat, float log)
	{
		Task task;
		List<HttpParameter> config = new List<HttpParameter> ()
        {
            new HttpParameter("oauth_consumer_key", appKey),
			new HttpParameter("oauth_version", "2.a"),
			new HttpParameter("format", "json"),
			new HttpParameter("content", txt),
			new HttpParameter("clientip", "127.0.0.1"),
			new HttpParameter("longitude", lat),
			new HttpParameter("latitude", log)
        };
//		Debug.Log("access_token=" + accessToken);
//		Debug.Log("Shareopenid=" + openID);
		task.commandType = T_ADD;
		task.requestMethod = RequestMethod.Post;
		task.parameters = config;
		//check if accesstoken expired
		if (!oauth.VerifierAccessToken ()) {
			ResponseResult result = new ResponseResult ();
			result.platformType = PlatformType.PLATFORM_TENCENTWEIBO;
			result.returnType = ReturnType.RETURNTYPE_OAUTH_FAILED;
			result.commandType = task.commandType;
			result.description = "invalid accessToken";
			lock (resultList) {
				resultList.Add (result);
			}
		} else {
			Debug.Log ("oauth.AccessToken----" + oauth.AccessToken);
			SendCommand (task);
		}		
	}
	/// <summary>
	/// post a status with uploading image 
	/// </summary>
	/// <param name="txt">content of status, less than 140 characters </param>
	/// <param name="pic">binary data of the uploading image, support format: JPEG、GIF、PNG, size limited: 5M </param>
	/// <returns></returns>
	private void ShareWithLocalImage (string txt, byte[] pic)
	{
		ShareWithLocalImage (txt, pic, 0, 0);
	}
	/// <summary>
	/// post a status with uploading image 
	/// </summary>
	/// <param name="txt">content of status, less than 140 characters </param>
	/// <param name="pic">binary data of the uploading image, support format: JPEG、GIF、PNG, size limited: 5M </param>
	/// <param name="lat">latitude from -90.0 to 90.0 default is 0.0</param>
	/// <param name="log">longitude from -180.0 to 180.0, default is 0.0 </param>
	/// <returns></returns>
	private void ShareWithLocalImage (string txt, byte[] pic, float lat, float log)
	{
		Task task;
		List<HttpParameter> config = new List<HttpParameter> ()
        {
            new HttpParameter("oauth_consumer_key", appKey),
			new HttpParameter("oauth_version", "2.a"),
			new HttpParameter("format", "json"),
			new HttpParameter("content", txt),
			new HttpParameter("clientip", "127.0.0.1"),
			new HttpParameter("longitude", lat),
			new HttpParameter("latitude", log),
			new HttpParameter("pic", pic),
			new HttpParameter("compatibleflag", 0x2|0x4|0x8|0x20)
        };
		task.commandType = T_ADD_PIC;
		task.requestMethod = RequestMethod.Post;
		task.parameters = config;
		//check if accesstoken expired
		if (!oauth.VerifierAccessToken ()) {
			ResponseResult result = new ResponseResult ();
			result.platformType = PlatformType.PLATFORM_TENCENTWEIBO;
			result.returnType = ReturnType.RETURNTYPE_OAUTH_FAILED;
			result.commandType = task.commandType;
			result.description = "invalid accessToken";
			lock (resultList) {
				resultList.Add (result);
			}
		} else {
			SendCommand (task);
		}
	}		

	/// <summary>
	/// post a status with uploading image 
	/// </summary>
	/// <param name="txt">content of status, less than 140 characters </param>
	/// <param name="pic">local path uploading image, support format: JPEG、GIF、PNG, size limited: 5M </param>
	/// <returns></returns>
	private void ShareWithLocalImage (string txt, string imgPath)
	{
		//read image
		byte[] pic;
		try {
			FileStream fs = new FileStream (imgPath, FileMode.Open);
			BinaryReader sr = new BinaryReader (fs);
			pic = sr.ReadBytes ((int)fs.Length);
			sr.Close ();
			fs.Close ();
		} catch {
			return;
		}
		ShareWithLocalImage (txt, pic, 0, 0);
	}
	
	/// <summary>
	/// post a status with uploading image 
	/// </summary>
	/// <param name="txt">content of status, less than 140 characters </param>
	/// <param name="imgPath">local path of the uploading image, support format: JPEG、GIF、PNG, size limited: 5M </param>
	/// <param name="lat">latitude from -90.0 to 90.0 default is 0.0</param>
	/// <param name="log">longitude from -180.0 to 180.0, default is 0.0 </param>
	/// <param name="annotations">custom infomation, json format, less than 512 characters</param> 
	/// <returns></returns>	
	private void ShareWithLocalImage (string txt, string imgPath, float lat, float log, string annotations)
	{
		//read image
		byte[] pic;
		try {
			FileStream fs = new FileStream (imgPath, FileMode.Open);
			BinaryReader sr = new BinaryReader (fs);
			pic = sr.ReadBytes ((int)fs.Length);
			sr.Close ();
			fs.Close ();
		} catch {
			return;
		}
		ShareWithLocalImage (txt, pic, lat, log);
	}		

	/// <summary>
	/// post a status with image link 
	/// </summary>
	/// <param name="content"> content of status, less than 140 characters </param>
	/// <param name="picUrl"> url of image </param>
	/// <returns></returns>		
	private void ShareWithImageUrl (string content, string picUrl)
	{
		ShareWithImageUrl (content, picUrl, 0, 0, "");
	}
	
	/// <summary>
	/// post a status with image link 
	/// </summary>
	/// <param name="content"> content of status, less than 140 characters </param>
	/// <param name="picUrl"> local path or external url of image </param>
	/// <param name="lat"> latitude from -90.0 to 90.0 default is 0.0</param>
	/// <param name="log"> longitude from -180.0 to 180.0, default is 0.0 </param>
	private void ShareWithImageUrl (string content, string picUrl, float lat, float log, string annotations)
	{
		Task task;
		List<HttpParameter> config = new List<HttpParameter> ()
        {
            new HttpParameter("oauth_consumer_key", appKey),
			new HttpParameter("oauth_version", "2.a"),
			new HttpParameter("format", "json"),
			new HttpParameter("content", content),
			new HttpParameter("clientip", "127.0.0.1"),
			new HttpParameter("longitude", lat),
			new HttpParameter("latitude", log),
			new HttpParameter("pic_url", picUrl),
			new HttpParameter("compatibleflag", 0x2|0x4|0x8|0x20)
        };
		task.commandType = T_ADD_PIC_URL;
		task.requestMethod = RequestMethod.Post;
		task.parameters = config;
		//check if accesstoken expired
		if (!oauth.VerifierAccessToken ()) {
			ResponseResult result = new ResponseResult ();
			result.platformType = PlatformType.PLATFORM_TENCENTWEIBO;
			result.returnType = ReturnType.RETURNTYPE_OAUTH_FAILED;
			result.commandType = task.commandType;
			result.description = "invalid accessToken";
			lock (resultList) {
				resultList.Add (result);
			}
		} else {
			SendCommand (task);
		}
	}			
	/// <summary>
	/// post a status with image link 
	/// </summary>
	/// <param name="content"> content of status, less than 140 characters </param>
	/// <param name="imgPath"> local path or external url of image </param>
	/// <param name="lat"> latitude from -90.0 to 90.0 default is 0.0</param>
	/// <param name="log"> longitude from -180.0 to 180.0, default is 0.0 </param>
	/// <param name="annotations">custom infomation, json format, less than 512 characters</param> 		
	public void ShareWithImage (string content, string imgPath, float lat, float log, string annotations)
	{
		if (imgPath.StartsWith ("http")) {
			ShareWithImageUrl (content, imgPath, lat, log, annotations);
		} else {
			ShareWithLocalImage (content, imgPath, lat, log, annotations);
		}
	}
	
	/// <summary>
	/// post a status with image link 
	/// </summary>
	/// <param name="content"> content of status, less than 140 characters </param>
	/// <param name="imgPath"> local path or external url of image </param>
	/// <returns></returns>	
	public void ShareWithImage (string content, string imgPath)
	{
		if (imgPath.StartsWith ("http")) {
			ShareWithImageUrl (content, imgPath);
		} else {
			ShareWithLocalImage (content, imgPath);
		}
	}

	protected override string SetupTask (Task task)
	{
		task.parameters.Add (new HttpParameter ("openid", oauth.OpenID));
		Debug.Log ("openid=" + oauth.OpenID);
		return base.SetupTask (task);
	}	
	
	protected override void HandleResponse (ResponseResult result)
	{
		
		if (string.IsNullOrEmpty (result.description)) {
			result.returnType = ReturnType.RETURNTYPE_OTHER_ERROR;
		} else if (result.description.IndexOf ("errcode") >= 0) {
			var json = JsonReader.Deserialize<Dictionary<string, object>> (result.description);
			string strErrorCode = json ["errcode"].ToString ();
			if (strErrorCode == "0") {
				result.returnType = ReturnType.RETURNTYPE_SUCCESS;
			} else if (strErrorCode == "1" 
				|| strErrorCode == "2" 
				|| strErrorCode == "3"
				|| strErrorCode == "4"
				|| strErrorCode == "5"
				|| strErrorCode == "6") {
				result.returnType = ReturnType.RETURNTYPE_OAUTH_FAILED;
				//Logout();
			} else {
				result.returnType = ReturnType.RETURNTYPE_OTHER_ERROR;
			}
		} else {
			result.returnType = ReturnType.RETURNTYPE_OTHER_ERROR;
		}
		base.HandleResponse (result);
	}	
}
