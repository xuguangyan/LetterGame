package com.dasheng
{
	import flash.display.*;
	import flash.geom.*;
	
	//**图形资源类**
	public class GraphicsResource
	{
		public var bitmap:BitmapData = null;//位图数据
		public var bitmapAlpha:BitmapData = null;//透明通道
		public var frames:int = 1;//帧数
		public var fps:Number = 0;//帧频
		public var drawRect:Rectangle = null;//绘图区
		
		//构建图形资源
		public function GraphicsResource(image:DisplayObject, frames:int = 1, fps:Number = 0, drawRect:Rectangle = null)
		{
			bitmap = createBitmapData(image);
			bitmapAlpha = createAlphaBitmapData(image);
			this.frames = frames;
			this.fps = fps;
			if (drawRect == null)
				this.drawRect = bitmap.rect;
			else
				this.drawRect = drawRect;
		}
		
		//创建位图数据
		protected function createBitmapData(image:DisplayObject):BitmapData
		{
			var bitmap:BitmapData = new BitmapData(image.width, image.height);
			bitmap.draw(image);
			return bitmap;
		}
		
		//创建透明通道
		protected function createAlphaBitmapData(image:DisplayObject):BitmapData
		{
			var bitmap:BitmapData = new BitmapData(image.width, image.height);
			bitmap.draw(image, null, null, flash.display.BlendMode.ALPHA);
			return bitmap;
		}

	}
}