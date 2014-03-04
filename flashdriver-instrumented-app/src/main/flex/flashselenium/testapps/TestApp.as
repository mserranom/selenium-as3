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

import mx.logging.ILogger;
import mx.logging.Log;
import mx.logging.LogEventLevel;

[SWF(backgroundColor="0x999999")]
public class TestApp extends Sprite
{

    private var label:TextField;

    private var myLabel : MyLabel;

    public function TestApp()
    {

        Cc.startOnStage(stage, "`");
        Cc.width = stage.width * 0.7;
        Cc.commandLine = true;
        Cc.config.commandLineAllowed = true;

        Cc.visible = true;

        initializeConsoleTarget();

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

        addEventListener(Event.ENTER_FRAME, onEnterFrame);

        new FlashDriver().connect();

        FlashDriver.registerFunction("callback", buildMessage);

    }

    private static var consoleLogTarget : ConsoleLogTarget;


    private static function initializeConsoleTarget() : void
    {
        consoleLogTarget = new ConsoleLogTarget();
        consoleLogTarget.includeTime = true;
        consoleLogTarget.includeCategory = true;
        consoleLogTarget.includeLevel = true;
        consoleLogTarget.filters = ["*"];
        consoleLogTarget.level = LogEventLevel.ALL;
        Log.addTarget(consoleLogTarget);
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

        FlashDriver.registerElementByID("rect1", rect1);
        FlashDriver.registerElementByID("rect2", rect2);
    }

    private function onEnterFrame(...rest) : void
    {
        label.text = "myText";
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

        FlashDriver.registerElementByID("label", label);

//        Security.loadPolicyFile("xmlsocket://127.0.0.1:55000");
        var logger : ILogger = Log.getLogger("app");
        logger.info("connecting");
    }

    private function buildMessage(hello:String, world:String)
    {
        return hello + " " + world + "!!";
    }
}
}
