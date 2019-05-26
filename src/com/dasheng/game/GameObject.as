package com.dasheng.game
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import com.dasheng.GraphicsResource;
	
	//**游戏部件类**
	public class GameObject extends BaseObject
	{
		public var graphics:GraphicsResource = null;
		public var position:Point = new Point(0,0);
		
		public function GameObject()
		{
		}
		
		//拷贝到缓冲区(适用于单帧对象)
		protected function copyToBackBuffer(db:BitmapData):void
		{
			db.copyPixels(graphics.bitmap, graphics.bitmap.rect, position, graphics.bitmapAlpha, new Point(0, 0), true);
		}
		
		//设置缓冲区当前帧(适用于多帧对象)
		protected function setFrame(db:BitmapData,index:int):void
		{
			var width:int=graphics.bitmap.width/graphics.frames;
			var height:int=graphics.bitmap.height;
			var rect:Rectangle=new Rectangle(index*width,0,width,height)
			db.copyPixels(graphics.bitmap, rect, position, graphics.bitmapAlpha,new Point(index*width,0), true);
		}	

	}
}