import com.dasheng.*;
import com.dasheng.game.*;
import com.dasheng.ui.*;

import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

import mx.controls.Alert;

private var table:Table;	//网格
private var cursor:Cursor;	//光标

private var curImg:ImageEx;	//当前ImageEx
private var curID:String="";//当前ID
private var curName:String="";//当前Name

private var curScore:int=0;	//当前积分
private var curRight:int=0;	//当前正确
private var curWrong:int=0;	//当前失误
private var seconds:int=0;	//当前秒数
private var secondLeft:int=0;	//剩余秒数

private var secondTimer:Timer;//定时器（用于游戏计时）
private var miniTimer:Timer   //定时器(用于计剩余分)
private var bombTimer:Timer   //定时器(用于炸弹效果)

private var mySound:MySound;//音乐

private var isFirst:Boolean=true;
private var isBgSound:Boolean=true;
private var isTmSound:Boolean=false;

private var bufBmpAbout:BitmapData;//缓冲区

private var mapAbout:MapObject;//地图
private var cloud1:CloudObject;//云块1
private var cloud2:CloudObject;//云块2
private var cloud3:CloudObject;//云块3

private var bombMc1:MovieClip;//炸弹1
private var bombMc2:MovieClip;//炸弹2
private var lines1:Sprite;

//创建完成
protected function onCreationComplete():void
{
	cursor = new Cursor();
	curImg = new ImageEx();
	mySound = new MySound();
	table = new Table();
	table.show(myCanvas,onBoxClick,onBoxMsover,onBoxMsout);
	
	//定时器
	secondTimer = new Timer(1000);
	secondTimer.addEventListener(TimerEvent.TIMER,onSecondTimer);
	miniTimer = new Timer(100);
	miniTimer.addEventListener(TimerEvent.TIMER,onMiniTimer);
	bombTimer = new Timer(700,1);
	bombTimer.addEventListener(TimerEvent.TIMER_COMPLETE,onBombTimer);
	
	fileBar.height=0;
	//myCanvas.enabled=false;
	
	//缓冲区(关于场景)
	bufBmpAbout = new BitmapData(900,500);
	
	//创建地图
	mapAbout=new MapObject(bufBmpAbout);
	mapAbout.graphics=Resource.BlueGraphics;
	mapAbout.position=new Point(0,0);
	
	//创建云块1
	cloud1=new CloudObject(bufBmpAbout);
	cloud1.graphics=Resource.CloudGraphics;
	cloud1.position=new Point(20,20);
	//创建云块2
	cloud2=new CloudObject(bufBmpAbout);
	cloud2.graphics=Resource.CloudGraphics;
	cloud2.position=new Point(280,100);
	//创建云块3
	cloud3=new CloudObject(bufBmpAbout);
	cloud3.graphics=Resource.CloudGraphics;
	cloud3.position=new Point(630,20);
	
	//炸弹1
	bombMc1 = new Resource.BombMC() as MovieClip;
	bombMc1.width=83;
	bombMc1.height=70;
	bombMc1.stop();
	bombMc1.visible=false;
	myUI.addChild(bombMc1);
	//炸弹2
	bombMc2 = new Resource.BombMC() as MovieClip;
	bombMc2.width=83;
	bombMc2.height=70;
	bombMc2.visible=false;
	bombMc2.stop();
	myUI.addChild(bombMc2);
	//连线
	lines1 = new Sprite();
	myUI.addChild(lines1);
}

//进入帧
private function onEnterFrame(event:Event):void
{
	mapAbout.paste();
	cloud1.draw();
	cloud2.draw();
	cloud3.draw();
	flush();
}
		
//重刷画布
private function flush():void
{
	AboutCanvas.graphics.clear();
	AboutCanvas.graphics.beginBitmapFill(bufBmpAbout);
	AboutCanvas.graphics.drawRect(0,0,bufBmpAbout.width,bufBmpAbout.height);
	AboutCanvas.graphics.endFill();
}

//点击关于按钮
private function onAboutClick(event:MouseEvent):void
{
	currentState="About";
}

//点击返回按钮
private function onBtnBack(event:MouseEvent):void
{
	currentState="Game";
}

//切换Logo
private function logoSwitch():void
{
	myLogo2.visible=myLogo.visible;
	myLogo.visible=!myLogo.visible;
}

//点击声音按钮
private function onSoundClick(event:MouseEvent):void
{
	if(isBgSound)
	{
		mySound.puseBgSound();
		imgSound.source=Config.SOUND_OFF;
		isBgSound=false;
		lbMsg.text="当前状态：声音关闭";
	}
	else
	{
		mySound.playBgSound();
		imgSound.source=Config.SOUND_ON;
		isBgSound=true;
		lbMsg.text="当前状态：声音开启";
	}
}

//调节声音
private function onVolumeChange(event:Event):void
{
	mySound.setVolume(sldVolume.value);
	lbMsg.text="当前状态：调节声音为"+Math.ceil(sldVolume.value*100).toString();
}

//鼠标按下
private function onMouseDown(event:MouseEvent):void
{
	cursor.setCursor(CursorType.PRESS);
}

//鼠标弹起
private function onMouseUp(event:MouseEvent):void
{
	cursor.setCursor(CursorType.NORMAL);
}

//点击重新开始
private function onBtnReset(event:MouseEvent):void
{
	table.setRandOrder();
	table.clearBorder();
	curID="";
	curName="";
	
	if(isFirst)
	{
		secondTimer.start();
		btnReset.label="重新开始";
		isFirst=false;
	}
	else
	{
		secondTimer.reset();
		secondTimer.start();
		seconds=0;
		fileBar.height=0;
		lbMsg.text="当前状态："+Tools.getNowTime(0);
	}
	curScore=0;
	curRight=0;
	curWrong=0;
	
	txtScore.text="0";
	txtRight.text="0";
	txtWrong.text="0";
	//myCanvas.enabled=true;
	effBack.target=imgBg;
	effBack.play();
}

//定时器（用于游戏计时）
private function onSecondTimer(event:TimerEvent):void
{
	seconds++;
	if(seconds>Config.GAME_TIME)
	{
		mx.controls.Alert.show("很遗憾，闯关失败！");
		secondTimer.stop();
		//myCanvas.enabled=false;
		effBack.play(null,true);
		
		//停止摧时音乐
		if(isTmSound)
		{
			mySound.puseTmSound();
			isTmSound=false;
		}
		
		return;
	}
	fileBar.height=seconds*(360/Config.GAME_TIME);
	lbMsg.text="当前状态："+Tools.getNowTime(seconds);
	
	//开启摧时音乐
	if(!isTmSound && fileBar.height>=300)
	{
		mySound.playTmSound();
		isTmSound=true;
	}
	
	logoSwitch();
}

//定时器(用于计剩余分)
private function onMiniTimer(event:TimerEvent):void
{
	//每剩余10秒加5分
	secondLeft-=2;
	if(secondLeft>=0)
	{
		//剩余时间处理
		doCount();
	}
	else
	{
		miniTimer.stop();
		secondLeft=0;
		mx.controls.Alert.show("恭喜你，闯关成功！");
	}
	fileBar.height=(Config.GAME_TIME-secondLeft)*(360/Config.GAME_TIME);
}

//定时器(用于炸弹效果)
private function onBombTimer(event:TimerEvent):void
{
	table.hide(bombMc1.name);
	table.hide(bombMc2.name);
	
	bombMc1.visible=false;
	bombMc1.stop();
	
	bombMc2.visible=false;
	bombMc2.stop();
	
	lines1.graphics.clear();
}

//鼠标悬停单元格
private function onBoxMsover(event:MouseEvent):void
{
	var img:ImageEx=event.currentTarget as ImageEx;
	
	if(curID==""||img.id!=curImg.id)
	{
		img.setBorder(4,6,0xFFCC00);
		myCanvas.setChildIndex(img,myCanvas.numChildren-1);
		if(curID!="")
			myCanvas.setChildIndex(curImg,myCanvas.numChildren-1);
	}
}

//鼠标移出单元格
private function onBoxMsout(event:MouseEvent):void
{
	var img:ImageEx=event.currentTarget as ImageEx;
	if(curID==""||img.id!=curImg.id)
	{
		img.setBorder();
	}
}

//鼠标点击单元格
private function onBoxClick(event:MouseEvent):void
{
	var img:ImageEx=event.currentTarget as ImageEx;
	if(curRight<26&&img.name=="DX")
	{
		//操作失误
		doWrong()
		return;
	}
	
	if(curID!=""&&img.name==curImg.name && img.id!=curImg.id)
	{
		//操作成功
		doRight();

		//爆炸效果
		bombMc1.x=curImg.x+35;
		bombMc1.y=curImg.y+35;
		bombMc1.visible=true;
		bombMc1.name=curID;
		bombMc1.play();
		
		bombMc2.x=img.x+35;
		bombMc2.y=img.y+35;
		bombMc2.visible=true;
		bombMc2.name=img.id;
		bombMc2.play();
		
		lines1.graphics.lineStyle(5,0xFF0000,1);
		lines1.graphics.moveTo(curImg.x+35,curImg.y+35);
		lines1.graphics.lineTo(img.x+35,img.y+35);
		
		curID="";
		
		//延时处理隐藏对象
		bombTimer.start();

		//闯关成功
		if(curRight>=27)
		{
			secondLeft=Config.GAME_TIME-seconds;
			secondTimer.stop();
			miniTimer.start();
			//myCanvas.enabled=false;
			effBack.play(null,true);
			
			//停止摧时音乐
			if(isTmSound)
			{
				mySound.puseTmSound();
				isTmSound=false;
			}
		}
	}
	else
	{
		if(curID!="")
		{
			//操作失误
			doWrong()
			return;
		}
		curImg.setBorder();
		img.setBorder(4,6,0xFF0000);
		curImg=img;
		curID=img.id;
		myCanvas.setChildIndex(img,myCanvas.numChildren-1);
		
		//按键音
		mySound.playSndClick();
	}
}

//执行操作成功处理
private function doRight():void
{
	//正确次数累计
	curRight++;
	txtRight.text=curRight.toString();
	//完成音
	mySound.playSndDone();
	//加分动画
	effScoreShow(10);
}

//执行操作失误处理
private function doWrong():void
{
	//失误次数累计
	curWrong++;
	txtWrong.text=curWrong.toString();
	//警告音
	mySound.playSndWarn();
	//减分动画
	effScoreShow(-5);
}

//执行剩余时间处理
private function doCount():void
{
	//播放数钱音
	mySound.playSndCount();
	//加分动画
	effScoreShow(1);
}

//加分效果显示
private function effScoreShow(num:int):void
{
	curScore+=num;
	txtScore.text=curScore.toString();
	
	switch(num)
	{
		case 10:
			mcNum.source="media/img/num+10.png";
			break;
		case 1:
			mcNum.source="media/img/num+1.png";
			break;
		case -5:
			mcNum.source="media/img/num-5.png";
			break;
	}
	effScore.play();
}