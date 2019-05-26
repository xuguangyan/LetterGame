package com.dasheng
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
	
	//**声音类**
	public class MySound
	{
		
		private var soundVol:SoundTransform;//声音音量
		
		private var bgSound:Sound;//背景音乐
		private var bgChannel:SoundChannel;//背景音乐
		private var bgSoundPos:int=0;//背景音乐进度
		
		private var tmSound:Sound;//摧时音乐
		private var tmChannel:SoundChannel;//摧时音乐
		
		private var sndDone:Sound;//完成音
		private var sndClick:Sound;//按键音
		private var sndWarn:Sound;//警告音
		private var sndCount:Sound;//数钱音

		public function MySound(vol:Number=0.5)
		{
			//声音音量
			soundVol = new SoundTransform();
			soundVol.volume=vol;
			
			//背景音乐
			bgSound = new Sound();
			bgSound.load(new URLRequest(Config.SOUND_FILE_BACK));
			playBgSound();
			
			//摧时音乐
			tmSound= new Sound();
			tmSound.load(new URLRequest(Config.SOUND_FILE_TIMEUP));
			
			//完成音
			sndDone= new Sound();
			sndDone.load(new URLRequest(Config.SOUND_FILE_DONE));
			
			//按键音
			sndClick= new Sound();
			sndClick.load(new URLRequest(Config.SOUND_FILE_CLICK));
			
			//警告音
			sndWarn= new Sound();
			sndWarn.load(new URLRequest(Config.SOUND_FILE_WARN));
			
			//数钱音
			sndCount= new Sound();
			sndCount.load(new URLRequest(Config.SOUND_FILE_COUNT));
		}
		
		//打开背景音乐
		public function playBgSound():void
		{
			bgChannel=bgSound.play(bgSoundPos,1,soundVol);
			bgChannel.addEventListener(Event.SOUND_COMPLETE,function():void{
				bgSoundPos=0;
				playBgSound();
			});
			
		}
		
		//打开背景音乐
		public function playBgSoundAt(pos:int=0):void
		{
			bgSoundPos=pos;
			bgChannel=bgSound.play(bgSoundPos,1,soundVol);
			bgChannel.addEventListener(Event.SOUND_COMPLETE,function():void{
				playBgSoundAt(pos);
			});
		}
		
		//暂停背景音乐
		public function puseBgSound():void
		{
			bgSoundPos=bgChannel.position;
			bgChannel.stop();
		}
		
		//打开摧时音乐
		public function playTmSound():void
		{
			tmChannel=tmSound.play(0,int.MAX_VALUE,soundVol);
		}
		
		//暂停摧时音乐
		public function puseTmSound():void
		{
			tmChannel.stop();
		}
		
		//播放完成音
		public function playSndDone():void
		{
			sndDone.play(0,1,soundVol);
		}
		
		//播放按键音
		public function playSndClick():void
		{
			sndClick.play(0,1,soundVol);
		}
		
		//播放警告放音
		public function playSndWarn():void
		{
			sndWarn.play(0,1,soundVol);
		}
		
		//播放数钱音
		public function playSndCount():void
		{
			sndCount.play(0,1,soundVol);
		}
		
		//设置音量
		public function setVolume(vol:Number):void
		{
			soundVol.volume=vol;
			bgChannel.soundTransform=soundVol;
		}
	}
}