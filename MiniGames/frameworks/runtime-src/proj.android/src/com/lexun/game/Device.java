package com.lexun.game;

import org.cocos2dx.lib.Cocos2dxActivity;
import android.telephony.TelephonyManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.app.DatePickerDialog;
import android.widget.DatePicker;
import java.util.Calendar;
import org.cocos2dx.lib.Cocos2dxLuaJavaBridge;

import org.cocos2dx.lua.AppActivity;

public class Device {
	public static Cocos2dxActivity context;

	public static void setContext(Cocos2dxActivity context_) {
		context = context_;
	}

	// imei
	public static String imei() {
		TelephonyManager tm = (TelephonyManager) context
				.getSystemService(Context.TELEPHONY_SERVICE);
		return tm.getDeviceId();
	}

	public static String brand() {
		return android.os.Build.MODEL.split(" ")[0];
	}

	public static String model() {
		if(android.os.Build.MODEL.indexOf(" ")!=-1)
			return android.os.Build.MODEL.split(" ")[1];
		else
			return android.os.Build.MODEL;
	}

	public static String OSVersion() {
		return android.os.Build.VERSION.RELEASE;
	}

	public static String macAddress() { 
        WifiManager wifi = (WifiManager) context.getSystemService(Context.WIFI_SERVICE); 
        WifiInfo info = wifi.getConnectionInfo(); 
        return info.getMacAddress(); 
    } 

	public static int kindofNetwork() {
		int net_type = -1;
		ConnectivityManager cm = 
				(ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
		NetworkInfo netInfo = cm.getActiveNetworkInfo();

		net_type = netInfo.getType();
		
		return net_type;
	}

	public static boolean networkReachable() {
		ConnectivityManager cm = (ConnectivityManager)context.getSystemService(Context.CONNECTIVITY_SERVICE);
        if (null != cm) {  
            NetworkInfo networkInfo = cm.getActiveNetworkInfo();
            if(networkInfo != null) {
                return networkInfo.isAvailable();
            }
        }
		
		return false;
	}

	public static String ip() {
		return AppActivity.getLocalIpAddress();
	}

	public static void isIndex(boolean isIndex)
    {
        AppActivity.isIndex = isIndex;
    }

	public static void showPage(final String url,final String title){
    	Intent intent = new Intent(context, WebViewActivity.class);
		intent.putExtra("title", title);
		intent.putExtra("url",  url);
		intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP|Intent.FLAG_ACTIVITY_NEW_TASK);
		context.startActivity(intent);
    }

    /**
	 * 调用系统选择日期
	 */
	public static void showDate(final int datecallback)
	{
		if(context != null)
		{
			context.runOnUiThread(new Runnable(){

				@Override
				public void run() 
				{
					DatePickerDialog.OnDateSetListener listen = new DatePickerDialog.OnDateSetListener() {
						
						@Override
						public void onDateSet(DatePicker view, int year, int monthOfYear,int dayOfMonth) 
						{
							// TODO Auto-generated method stub
							final String result = String.format("%04d-%02d-%02d", year,monthOfYear+1,dayOfMonth);
							context.runOnGLThread(new Runnable()
							{

								@Override
								public void run() 
								{
									// TODO Auto-generated method stub
									if(datecallback != 0)
									{
										Cocos2dxLuaJavaBridge.callLuaFunctionWithString(datecallback, result);
									}
									
								}});
						}
					};
					Calendar cal = Calendar.getInstance();
					new DatePickerDialog(context,listen,cal.get(Calendar.YEAR),cal.get(Calendar.MONTH),cal.get(Calendar.DAY_OF_MONTH)).show();
				}});
			
		}
		
	}
}
