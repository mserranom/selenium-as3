package flashselenium.testapps
{
import flash.text.TextField;
import flash.text.TextFormat;

public class MyLabel extends TextField
{
    public function MyLabel()
    {
        var format:TextFormat = new TextFormat();
        format.font = "Verdana";
        format.color = 0xFFFFFF;
        format.size = 10;
        format.underline = false;
        defaultTextFormat = format;
    }
}
}
