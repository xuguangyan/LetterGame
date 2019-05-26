package com.dasheng
{
	//**工具类**
	public final class Tools
	{
		//返回补零数据
		public static function getNumber(num:int):String
		{
			var strNum:String="0"+num.toString()
			return strNum.substring(strNum.length-2);
		}
		
		//返回文件名(无后缀)
		public static function getFileName(path:String):String
		{
			var fileName:String;
			var iEnd:int=path.lastIndexOf(".");
			var iBegin:int=path.lastIndexOf("/");
			iEnd=iEnd<0?0:iEnd;
			iBegin=iBegin<0?0:iBegin+1;
			fileName=path.substring(iBegin,iEnd);
			
			return fileName;
		}
		
		//返回文件名(无后缀)
		public static function getImgName(path:String):String
		{
			var file:String=getFileName(path);//返回文件名(无后缀)
			var img:String=file.substr(0,file.length-2);//去掉命名规则中的“_0”末尾
			return img;
		}
		
		//返回时刻(MM:SS)
		public static function getNowTime(seconds:int):String
		{
			var ss:int,mm:int;
			mm = Math.floor(seconds/60);
			ss = seconds % 60;
			
			return getNumber(mm)+" 分 "+getNumber(ss)+" 秒"
		}
	}
}