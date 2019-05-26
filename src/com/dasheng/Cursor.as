package com.dasheng
{
	import mx.managers.CursorManager;
	
	//**光标类**
	public class Cursor
	{
		private var cursorID:Number;
		
		public function Cursor():void
		{
			cursorID = CursorManager.setCursor(Resource.cursorPoint);//更改鼠标图标
		}
		
		//更改鼠标图标
		public function setCursor(type:int):void
		{
			//还原鼠标图标
			removeCursor();
			
			//更换光标手型
			switch(type)
			{
				case CursorType.NORMAL:
					cursorID = CursorManager.setCursor(Resource.cursorPoint);
					break;
				case CursorType.PRESS:
					removeCursor();
					cursorID = CursorManager.setCursor(Resource.cursorPress);
					break;
			}
		}
		
		//还原鼠标图标
		public function removeCursor():void
		{
			CursorManager.removeCursor(cursorID);
		}
	}
}