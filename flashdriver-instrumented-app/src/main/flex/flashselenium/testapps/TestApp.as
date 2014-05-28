package flashselenium.testapps
{
import com.junkbyte.console.Cc;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import flashdriver.FlashDriver;

import mx.logging.Log;
import mx.logging.LogEventLevel;

[SWF(backgroundColor="0x999999")]
public class TestApp extends Sprite
{

    private var textField:TextField;

    private var myLabel : MyLabel;

    public function TestApp()
    {
        setupConsole();

        addTextField();
        addMyLabel();
        addShapes();
        addClickableCircle();

        addEventListener(Event.ENTER_FRAME, onEnterFrame);

        new FlashDriver().connect();
        FlashDriver.registerFunction("callback", buildMessage);
        FlashDriver.registerRoot(this.stage);

    }

    private function onEnterFrame(...rest) : void
    {
        textField.text = "myText";
    }

    private function setupConsole():void
    {
        Cc.startOnStage(stage, "`");
        Cc.width = stage.width * 0.7;
        Cc.commandLine = true;
        Cc.config.commandLineAllowed = true;

        Cc.visible = true;

        var consoleLogTarget : ConsoleLogTarget = new ConsoleLogTarget();
        consoleLogTarget.includeTime = true;
        consoleLogTarget.includeCategory = true;
        consoleLogTarget.includeLevel = true;
        consoleLogTarget.filters = ["*"];
        consoleLogTarget.level = LogEventLevel.ALL;
        Log.addTarget(consoleLogTarget);
    }

    private function addTextField():void {
        textField = new TextField();
        textField.autoSize = TextFieldAutoSize.LEFT;
        textField.background = false;
        textField.border = false;
        textField.multiline = true;
        textField.width = 500;
        textField.height = 1000;

        var format:TextFormat = new TextFormat();
        format.font = "Verdana";
        format.color = 0xFFFFFF;
        format.size = 12;
        format.underline = true;

        textField.defaultTextFormat = format;
        addChild(textField);

        FlashDriver.registerElementByID("label", textField);
    }

    private function addMyLabel():void
    {
        myLabel = new MyLabel();
        myLabel.x = 20;
        myLabel.y = 100;
        myLabel.text = "CLICK THE CIRCLE";
        addChild(myLabel);
    }

    private function addShapes():void
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

        FlashDriver.registerElementByID("rect1", rect1);
        FlashDriver.registerElementByID("rect2", rect2);
    }

    private function addClickableCircle():void
    {
        var circle : MyCircle = new MyCircle();
        addChild(circle);

        circle.addEventListener(MouseEvent.CLICK, function (...rest):void{
            myLabel.text = "CIRCLE CLICKED!!"; });
    }

    private function buildMessage(hello:String, world:String) : String
    {
        return hello + " " + world + "!!";
    }
}
}
