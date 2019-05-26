package com.dasheng.game
{
	import flash.display.BitmapData;
	
	//**云块类**
	public class CloudObject extends GameObject
	{
		private var db:BitmapData=null;
		
		public function CloudObject(db:BitmapData)
		{
			super();
			this.db=db;
		}
		
		//绘制
		public function draw():void
		{
			if(position.x>db.width)
				position.x=-graphics.bitmap.width;
			
			copyToBackBuffer(db);
			
			position.x+=5;//往右飘动
		}
	}
}