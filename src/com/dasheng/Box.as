package com.dasheng
{
	import com.dasheng.ui.ImageEx;
	
	import flash.events.MouseEvent;
	
	import mx.core.Container;
	
	//**单元格类**
	public class Box
	{
		private var row:int;	//所在行
		private var col:int;	//所在列
		private var img:ImageEx;//Image控件(重新封装)
		
		public function Box(row:int,col:int,path:String,id:String):void
		{
			img = new ImageEx();
			img.id=id;
			img.source=path;
			img.name=Tools.getImgName(path);//以文件名作为标识(如A_0.png记作A)
			
			this.row=row;
			this.col=col;
			this.img=img;
		}
		
		//添加监听事件_点击
		public function addEvent_click(fun:Function):void
		{
			img.addEventListener(MouseEvent.CLICK,fun);
		}
		
		//添加监听事件_鼠标悬停
		public function addEvent_msover(fun:Function):void
		{
			img.addEventListener(MouseEvent.MOUSE_OVER,fun);
		}
		
		//添加监听事件_鼠标移出
		public function addEvent_msout(fun:Function):void
		{
			img.addEventListener(MouseEvent.MOUSE_OUT,fun);
		}
		
		//设置图片路径
		public function setPath(path:String):void
		{
			img.source=path;
			img.name=Tools.getImgName(path);//以文件名作为标识(如A_0.png记作A)
			img.visible=true;
		}
		
		//显示单元格
		public function show(obj:Container):void
		{
			img.width=Config.BOX_WIDTH;
			img.height=Config.BOX_WIDTH;
			img.x=Config.OFFSET_X + col * Config.BOX_WIDTH;
			img.y=Config.OFFSET_Y + row * Config.BOX_HEIGHT
			//img.toolTip=img.id;
			
			obj.addChild(img);
		}
		
		//隐藏单元格
		public function hide():void
		{
			img.visible=false;
		}
		
		public function get ID():String
		{
			return img.id;
		}
		
		//设置边框
		public function setBorder(width:Number=0,alpha:Number=0,color:uint=0):void
		{
			img.setBorder(width,alpha,color);
		}
	}
}