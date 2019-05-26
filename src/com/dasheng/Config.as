package com.dasheng
{
	//**配置信息类**
	public final class Config
	{
		//偏移量
		public static const OFFSET_X:int=2;
		public static const OFFSET_Y:int=2;
		
		//单元格大小
		public static const BOX_WIDTH:int=70;
		public static const BOX_HEIGHT:int=70;

		//行列数
		public static const NUM_COLS:int=9;
		public static const NUM_ROWS:int=6;
		
		//Logo图片
		public static const LOGO_FILE_ONE:String="media/img/logo_01.png";
		public static const LOGO_FILE_TWO:String="media/img/logo_02.png";
		
		//About图片
		public static const LOGO_FILE_ABOUT:String="media/img/About.png";
		
		//声音开关图片
		public static const SOUND_ON:String="media/img/Sound_On.png";
		public static const SOUND_OFF:String="media/img/Sound_Off.png";
		
		//声音文件
		public static const SOUND_FILE_BACK:String="media/audio/theme.mp3";
		public static const SOUND_FILE_DONE:String="media/audio/done.mp3";
		public static const SOUND_FILE_CLICK:String="media/audio/click.mp3";
		public static const SOUND_FILE_WARN:String="media/audio/warn.mp3";
		public static const SOUND_FILE_TIMEUP:String="media/audio/timeup.mp3";
		public static const SOUND_FILE_COUNT:String="media/audio/count.mp3";
		
		//游戏时间(3分钟一局)
		public static const GAME_TIME:int=60*3;
	}
}