package com.dasheng
{
	import mx.collections.ArrayCollection;
	import mx.core.Container;
	
	//**网格类**
	public class Table
	{
		//单元格集合
		private var arrBox:ArrayCollection;
		private var letters:Letter;
		
		public function Table()
		{
			arrBox = new ArrayCollection();
			
			var rows:int = Config.NUM_ROWS;
			var cols:int = Config.NUM_COLS;
			
			letters = new Letter();
			
			//填充网格
			for(var i:int= 0; i<rows; i++)
			{
				for(var j:int= 0; j<cols; j++)
				{
					var id:String = "imgBox_"+Tools.getNumber(i*cols+j+1);
					var path:String = "media/letter/" + letters.getLetter(i*cols+j) + ".png"
					var box:Box = new Box(i,j,path,id);
					
					arrBox.addItem(box);
				}
			}
		}
		
		//显示网格
		public function show(obj:Container,funClick:Function=null,funMsover:Function=null,funMsout:Function=null):void
		{	
			for each(var box:Box in arrBox)
			{
				box.show(obj);
				box.addEvent_click(funClick);
				box.addEvent_msover(funMsover);
				box.addEvent_msout(funMsout);
			}
		}
		
		//隐藏单元格
		public function hide(id:String):void
		{
			for each(var box:Box in arrBox)
			{
				if(box.ID==id)
				{
					box.hide();
					return;
				}
			}
		}
		
		//打乱次序
		public function setRandOrder():void
		{
			letters.setRandOrder();
			var index:int=0;
			for each(var box:Box in arrBox)
			{
				box.setPath("media/letter/" + letters.getLetter(index) + ".png");
				index++;
			}
		}
		
		//清除边框
		public function clearBorder():void
		{
			for each(var box:Box in arrBox)
			{
				box.setBorder();
			}
		}
	}
}