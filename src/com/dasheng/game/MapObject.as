package com.dasheng.game
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	//**地图类**
	public class MapObject extends GameObject
	{
		private var db:BitmapData=null;
		
		private var rows:int=13;//地图行数
		private var cols:int=23;//地图列数
		private var block:int=40;//单元块大小
		
		public function MapObject(db:BitmapData)
		{
			super();
			this.db=db;
		}
		
		//绘制
		public function draw():void
		{
			for(var i:int=0;i<rows;i++)
				for(var j:int=0;j<cols;j++)
					db.copyPixels(graphics.bitmap,graphics.drawRect,new Point(j*block,i*block));
		}
		
		//粘贴
		public function paste():void
		{
			db.copyPixels(graphics.bitmap,graphics.drawRect,new Point(0,0));
		}
	}
}