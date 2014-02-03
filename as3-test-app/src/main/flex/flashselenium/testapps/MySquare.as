package flashselenium.testapps
{
import flash.display.Sprite;

public class MySquare extends Sprite
{
    public function MySquare()
    {
        graphics.beginFill(0xFFFFFF);
        graphics.drawRect(0,0,50,50);
        graphics.endFill();
    }
}
}
