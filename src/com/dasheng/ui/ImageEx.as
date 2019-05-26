package com.dasheng.ui
{
	import mx.controls.Alert;
	import mx.controls.Image;  
	
    //边框宽度   
    [Style(name="borderWidth", type="Number", format="Length", inherit="no")]   
    //边框透明度   
    [Style(name="borderAlpha", type="Number", format="Length", inherit="no")] 
    //边框颜色   
    [Style(name="borderColor", type="uint", format="Color", inherit="no")]     
    
    //**重写Image类(加上边框效果)**
	public class ImageEx extends Image
	{
		private var myWidth:Number=0;
		private var myAlpha:Number=0;
		private var myColor:uint=0;
		private var isFromStyle:Boolean=true;//更新还自样式表
		
		public function ImageEx()
		{
            super(); 
		}
		
		//设置边框
		public function setBorder(width:Number=0,alpha:Number=0,color:uint=0):void
		{
			myWidth=width;
			myAlpha=alpha;
			myColor=color;
			isFromStyle=false;
			
			invalidateDisplayList();
		}
       
       //重写函数
        override protected function updateDisplayList(w:Number, h:Number):void
        {   
            super.updateDisplayList(w,h);
            
            if(isFromStyle)
            {
	            if(getStyle('borderWidth'))
	            	myWidth=getStyle('borderWidth');
	            if(getStyle('borderAlpha'))
	            	myAlpha=getStyle('borderAlpha');
	            if(getStyle('borderColor'))
	            	myColor=getStyle('borderColor');
            }
            
            graphics.clear();
            graphics.lineStyle(myWidth,myColor,myAlpha,false); 
            
            if(myWidth==0)
            	return;  
           
            var x:Number=-(myWidth/2);   
            var y:Number=-(myWidth/2);   
            var width:Number=this.width+myWidth;   
            var height:Number=this.height+myWidth;  
            graphics.drawRect(x,y,width,height);         
        }  
	}
}