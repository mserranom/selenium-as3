package flashselenium.testapps
{
import flashselenium.*;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

[SWF(backgroundColor="0x000000")]
public class TestApp extends Sprite
{

    private var label:TextField;

    private var myLabel : MyLabel;

    public function TestApp()
    {

        configureLabel();


        myLabel = new MyLabel();
        myLabel.x = 20;
        myLabel.y = 100;
        myLabel.text = "CLICK THE CIRCLE";
        addChild(myLabel);

        addElements();

        var circle : MyCircle = new MyCircle();
        addChild(circle);

        circle.addEventListener(MouseEvent.CLICK, function (...rest):void{
            myLabel.text = "CIRCLE CLICKED!!"; });


        SeleniumConnector.init(this);

        addEventListener(Event.ENTER_FRAME, onEnterFrame);



    }

    private function addElements():void
    {
        var rect1 : MySquare = new MySquare();
        var sprite : Sprite = new Sprite();
        var rect2 : MySquare = new MySquare();
        addChild(rect1);
        rect1.addChild(sprite);
        sprite.addChild(rect2);
        rect1.x = 100;
        rect1.y = 200;
        rect2.x = 50;
        rect2.y = 100;
        rect2.scaleX = 0.74;
        rect1.doubleClickEnabled = true;
    }

    private function onEnterFrame(...rest) : void
    {
        label.text = SeleniumConnector.status;
    }

    private function configureLabel():void {
        label = new TextField();
        label.autoSize = TextFieldAutoSize.LEFT;
        label.background = false;
        label.border = false;
        label.multiline = true;
        label.width = 500;
        label.height = 1000;

        var format:TextFormat = new TextFormat();
        format.font = "Verdana";
        format.color = 0xFFFFFF;
        format.size = 12;
        format.underline = true;

        label.defaultTextFormat = format;
        addChild(label);
    }
}
}
