package com.lexun.game;
import java.io.ByteArrayOutputStream;
import java.io.File;
import org.cocos2dx.lib.Cocos2dxLuaJavaBridge;
import android.app.Activity;
import android.content.Intent;
import android.content.res.Resources;
import android.database.Cursor;
import android.net.Uri;
import android.net.http.SslError;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.util.Base64;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.webkit.DownloadListener;
import android.webkit.SslErrorHandler;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ImageButton;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

public class WebViewActivity extends Activity {
	public static final int GET_PHOTO_CAMERA = 1;
	public static final int GET_PHOTO_GALLARY = 2;

	public class CustomWebViewClient extends WebViewClient {
		@Override
		public void onReceivedSslError(WebView view, SslErrorHandler handler,
				SslError error) {
			handler.proceed();
		}

		public void onPageStarted(WebView view, String url, Bitmap favicon) {
			// take photo
			if(url.endsWith("openCamera")){
				view.stopLoading();
				TakePhoto();
				return;
			} else if(url.endsWith("openGallary")){
				view.stopLoading();
				GetGallary();
				return;
			} else if(url.endsWith("close")){
				view.stopLoading();
				finish();
				return;
			}
			
			if(titleString == null || titleString.equalsIgnoreCase("")){
				RelativeLayout.LayoutParams lParams = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.FILL_PARENT, ViewGroup.LayoutParams.FILL_PARENT);
				lParams.setMargins(0, 0, 0, 0);
				view.setLayoutParams(lParams);
				if(mTextView != null)
				{
					mTextView.setVisibility(View.GONE);
				}
				if(mBackButton != null)
				{
					mBackButton.setVisibility(View.GONE);
				}
				
			}
			
			Log.d("url", url);
			int index = url.indexOf("access_token");
			if (index >= 0) {
				if(luaCallback >= 0){
					Cocos2dxLuaJavaBridge.callLuaFunctionWithString(luaCallback, url.substring(index));
					Cocos2dxLuaJavaBridge.releaseLuaFunction(luaCallback);
					finish();
					super.onPageStarted(view, url, favicon);
					return;
				}
			}
			
			
			super.onPageStarted(view, url, favicon);

		}
	}
	// add 2014-05-28 实现下载的回调
	private class WebViewDownLoadListener implements DownloadListener 
	{

		public void onDownloadStart(String url, String userAgent,
				String contentDisposition, String mimetype,
				long contentLength) 
		{
			// TODO Auto-generated method stub
			try 
			{
				String t = url.trim();//去掉首尾空格
				String dest = null;
				if(t.startsWith("download") || t.startsWith("DOWNLOAD"))
				{
					dest = "http"+t.substring(8);
					
				}
				else
				{
					dest = t;
				}
				if(dest != null)
				{
					Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(dest));
					intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK|Intent.FLAG_ACTIVITY_CLEAR_TOP);
					startActivity(intent);
				}
				
			} 
			catch (Exception e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	

	}
	String oauthUrl;
	String titleString;
	int luaCallback = -1;
	int platform = -1;

	private WebView mWebView;
	private TextView mTextView;
	private ImageButton mBackButton;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		int layoutID = getField("activity_main", "layout");
		int mWebViewID = getField("webView", "id");
		int mTextViewID = getField("textView1", "id");
		int backButtonID = getField("button1", "id");
		
		setContentView(layoutID);
		mWebView = (WebView) findViewById(mWebViewID);
		mTextView = (TextView) findViewById(mTextViewID);
		mBackButton = (ImageButton) findViewById(backButtonID);
		if(mBackButton != null)
		{
			mBackButton.setOnClickListener(new OnClickListener(){
				public void onClick(View v) {
					finish();
				}
			});
		}
		
		
		mWebView.getSettings().setSavePassword(false);

		titleString = this.getIntent().getStringExtra("title");
		if(mTextView != null)
		{
			mTextView.setText(titleString);
		}
		oauthUrl = this.getIntent().getStringExtra("url");
		Log.d("oauthUrl", oauthUrl);
		if(oauthUrl != null){
			mWebView.loadUrl(oauthUrl);
		} else {
			String htmlString = this.getIntent().getStringExtra("html");
			if(htmlString != null){
				mWebView.loadDataWithBaseURL("", htmlString, "text/html", "UTF-8", "");
			}
		}
		
		luaCallback = this.getIntent().getIntExtra("luaCallback", -1);
		
		mWebView.getSettings().setJavaScriptEnabled(true);
		mWebView.setWebViewClient(new CustomWebViewClient());
		mWebView.setDownloadListener(new WebViewDownLoadListener());
	}

	protected void onDestroy() {
		super.onDestroy();
		mWebView = null;
		mTextView = null;
	}
	
	
	private int getField(String name, String type) {
		Resources res=getResources();
		int id = res.getIdentifier(name, type, getPackageName());
		Log.d("", "id:" + id);
		return id;
	}
	

	public boolean onKeyDown(int keyCode, KeyEvent event) {
		// TODO Auto-generated method stub
		if (keyCode == KeyEvent.KEYCODE_BACK && event.getRepeatCount() == 0) {
			finish();
		}
		return super.onKeyDown(keyCode, event);
	}
	
	
	public void GetGallary()
	{
		Intent intent=new Intent();
		intent.setType("image/*");
		intent.setAction(Intent.ACTION_GET_CONTENT);
		startActivityForResult(intent, GET_PHOTO_GALLARY);
	}
	
	String path;
	public void TakePhoto()
	{
		Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE); //"android.media.action.IMAGE_CAPTURE";
		if(isHasSdcard()){
			Long time = System.currentTimeMillis();
			String root = Environment.getExternalStorageDirectory().getAbsolutePath();
			path = root+"/lexun_bubble/Image_"+time.toString()+".png";
			File vFile = new File(path);
			if(!vFile.exists())
			{
				File vDirPath = vFile.getParentFile(); //new File(vFile.getParent());
				vDirPath.mkdirs();
			}
			Log.e("rmb", path);
			Uri photoUri = Uri.fromFile(vFile);
			//intent.putExtra(MediaStore.EXTRA_VIDEO_QUALITY, 0);
			intent.putExtra(MediaStore.EXTRA_OUTPUT,photoUri);
		} 
		startActivityForResult(intent, GET_PHOTO_CAMERA);
	}
	
	@Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		if(resultCode==Activity.RESULT_OK){
			if(requestCode==GET_PHOTO_GALLARY) {  
				if(data == null)  
	            {  
	                Toast.makeText(this, "选择图片文件出错", Toast.LENGTH_LONG).show();  
	                return;  
	            }  
	            Uri photoUri = data.getData();  
	            if(photoUri == null )  
	            {  
	                Toast.makeText(this, "选择图片文件出错", Toast.LENGTH_LONG).show();  
	                return;  
	            }  
	            //通过URI获取图片绝对地址            
	            String[] proj = { MediaStore.Images.Media.DATA };
	            Cursor cursor = managedQuery(photoUri,proj,null,null,null);
	            int actual_image_column_index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
	            //游标跳到首位，防止越界            
	            cursor.moveToFirst();
	            String img_path = cursor.getString(actual_image_column_index);
	            Log.v("GET_PHOTO_GALLARY 1111111", img_path);
	            loadImageToWebView(img_path);
	            //String dd = "<HTML>这是<IMG src=\"file://"+img_path+"\"/>图片";

	            //mWebView.loadDataWithBaseURL(null, dd, "text/html", "utf-8", null);
	            Toast.makeText(this, img_path, Toast.LENGTH_LONG).show();  
	            //通过地址获得位图信息            
	            //bitmap =BitmapFactory.decodeFile(img_path);                
	            //设置ImageView资源            
	            //img.setImageBitmap(bitmap);
			} else if (requestCode==GET_PHOTO_CAMERA) {
				//存储卡可用
				if(isHasSdcard()){
					Log.v("GET_PHOTO_CAMERA 2222222", path);
					Toast.makeText(this, path, Toast.LENGTH_LONG).show();  
					loadImageToWebView(path);
				}
				else{
					//存储卡不可用直接返回缩略图 
					Bundle extras = data.getExtras(); 
					Bitmap bitmap = (Bitmap) extras.get("data");
					Log.v("GET_PHOTO_CAMERA 33333333", ""+bitmap.getHeight());
					Toast.makeText(this, "没有SDCard，缓存图片高度为"+bitmap.getHeight(), Toast.LENGTH_LONG).show();  
				}
			}
	     }
	}
	
	/**
	* 检查存储卡是否插入
	* @return
	*/
	public static boolean isHasSdcard()
	{
		String status = Environment.getExternalStorageState();
		if (status.equals(Environment.MEDIA_MOUNTED)){
		   return true;
		} else {
		   return false;
		}
	}
	
	public String onGestureReslut(Bitmap bitmap) {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();    
		bitmap.compress(Bitmap.CompressFormat.JPEG, 50, baos); 
		byte[] bytes = baos.toByteArray();
		String image64 = Base64.encodeToString(bytes, Base64.NO_WRAP);
		return image64;
	}
	
	public void loadImageToWebView(String img_path){
		Bitmap bitmap = BitmapFactory.decodeFile(img_path);
        String imgString = onGestureReslut(bitmap);
        mWebView.loadUrl("javascript:setGesture('data:image/jpeg;base64,"+imgString.trim()+"');"); 
	}
}
