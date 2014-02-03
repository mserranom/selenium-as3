package flashselenium.testapps
{
import flash.display.Sprite;

public class MyCircle extends Sprite
{

    public var shape : String = "circle";

    public function MyCircle()
    {
        graphics.beginFill(0xff0000);
        graphics.drawCircle(200,200,50);
        graphics.endFill();
    }
}
}
