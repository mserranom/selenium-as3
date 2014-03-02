package flashdriver.log
{
import flash.utils.getQualifiedClassName;

import mx.logging.ILogger;
import mx.logging.Log;

public class Logger
{
	public static function getLogger(clazz : Class) : ILogger
	{
		var className:String = getQualifiedClassName(clazz).replace("::", ".");
		return Log.getLogger(className);
	}
}
}
