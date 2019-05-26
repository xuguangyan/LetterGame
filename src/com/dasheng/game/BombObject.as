package com.dasheng.game
{
	import flash.display.BitmapData;
	
	//**炸弹类**
	public class BombObject extends GameObject
	{
		private var db:BitmapData=null;
		
		private var index:int=0;//当前帧
		private var count:int=1;//当前计数
		private var round:int=1;//播放次数
		
		public function BombObject(db:BitmapData)
		{
			super();
			this.db=db;
		}
		
		//绘制
		public function draw():void
		{
			if(count<round)
			{
				setFrame(db,index);
				index++;
				if(index>=graphics.frames)
				{
					index=0;
					count++;
				}
			}
		}
		
		//播放
		public function play(times:int=1):void
		{
			index=0;
			count=0;
			round=times;
		}
		
	}
}