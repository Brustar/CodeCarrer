package org.cocos2dx.lua;

import com.lexun.game.ResourceHelper;

import android.app.Activity;
import android.content.Intent;
import android.content.res.Resources;
import android.os.Bundle;
import android.os.Handler;

public class Launcher extends Activity 
{

	public final long TIMESEC = 2*1000;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) 
	{
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setContentView(ResourceHelper.getLayoutId(getPackageName(), "launcher"));
		new Handler().postDelayed(new Runnable()
		{

			@Override
			public void run() 
			{
				// TODO Auto-generated method stub
				finish();
				startGame();
			}}, TIMESEC);
	}
	public void startGame()
	{
		Intent newInt = new Intent(this,AppActivity.class);
		startActivity(newInt);
		overridePendingTransition(ResourceHelper.getAnimId(getPackageName(), "alpha_in"), ResourceHelper.getAnimId(getPackageName(), "alpha_out"));
	}
	@Override
	protected void onResume() 
	{
		// TODO Auto-generated method stub
		super.onResume();
	}

	@Override
	protected void onPause() {
		// TODO Auto-generated method stub
		super.onPause();
	}

	@Override
	protected void onDestroy() {
		// TODO Auto-generated method stub
		super.onDestroy();
	}

	@Override
	public void onBackPressed() 
	{
		// TODO Auto-generated method stub
		//super.onBackPressed();
	}
	
	
	

}
