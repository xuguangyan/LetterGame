package com.dasheng
{
	//**资源类**
	public final class Resource
	{
		//光标资源
		[Embed(source="media/img/hand_point.png")]
		public static var cursorPoint:Class;
		
		[Embed(source="media/img/hand_press.png")]
		public static var cursorPress:Class;
		
		//地图
		[Embed(source="media/img/green.png")]
		public static var GreenClass:Class;
		public static var GreenGraphics:GraphicsResource = new GraphicsResource(new GreenClass());
		
		[Embed(source="media/img/GameAboutBg.png")]
		public static var BlueClass:Class;
		public static var BlueGraphics:GraphicsResource = new GraphicsResource(new BlueClass());
		
		//炸弹
		[Embed(source="media/img/bomb.png")]
		public static var BombClass:Class;
		public static var BombGraphics:GraphicsResource = new GraphicsResource(new BombClass(), 7, 20);
		
		//云层
		[Embed(source="media/img/cloud.png")]
		public static var CloudClass:Class;
		public static var CloudGraphics:GraphicsResource = new GraphicsResource(new CloudClass());
		
		//炸弹
		[Embed(source="media/swf/res.swf",symbol="bomb")]
		public static var BombMC:Class;
	}
}