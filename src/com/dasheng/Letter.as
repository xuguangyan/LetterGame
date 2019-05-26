package com.dasheng
{
	import mx.collections.ArrayCollection;
	
	//**字母类**
	public class Letter
	{
		//字母集合
		private var arrLetter:ArrayCollection;
		
		public function Letter()
		{
			//用26个字母大小写填充集合
			arrLetter = new ArrayCollection();
			for(var i:int=0;i<26;i++)
			{
				//记录文件名(型如：A_0)
				arrLetter.addItem(String.fromCharCode(i+65)+"_0");
				arrLetter.addItem(String.fromCharCode(i+65)+"_1");
			}
			
			//补两个“大象”的标志
			arrLetter.addItem("DX_0");
			arrLetter.addItem("DX_1");
			
			/*此时：26 x 2 + 2 = 9 x 6 刚好填满网格*/
			
			//打乱次序
			setRandOrder();
		}
		
		//打乱次序
		public function setRandOrder():void
		{
			var arrNew:ArrayCollection= new ArrayCollection(arrLetter.toArray());
			arrLetter.removeAll();

			while(arrNew.length>0)
			{
				var len:int=arrNew.length;
				var index:int=Math.floor(Math.random()*len);
				arrLetter.addItem(arrNew.getItemAt(index));
				arrNew.removeItemAt(index);
			}
		}
		
		//以逗号隔开，返回所有集合对象
		public function getListString():String
		{
			return arrLetter.toString();
		}
		
		//返回索引为Index的字母文件名
		public function getLetter(index:int):String
		{
			var len:int=arrLetter.length;
			if(index>=len)
				index=Math.floor(Math.random()*len);
				
			return arrLetter.getItemAt(index).toString();
		}
	}
}