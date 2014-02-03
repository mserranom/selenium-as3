package flashselenium
{
import flash.display.DisplayObjectContainer;
import flash.events.TimerEvent;
import flash.external.ExternalInterface;
import flash.utils.Timer;

public class SeleniumConnector
{

    private static var instance : SeleniumConnector;

    public static var status : String = "not initiated"

    private var _robotEyesBridge : ExternalInterfaceBridge;


    public static function init(root:DisplayObjectContainer) : void
    {
        instance = new SeleniumConnector(root);
        instance.pollExternalInterface();
        status = "initiated;"
    }

    public function SeleniumConnector(root:DisplayObjectContainer)
    {
        _robotEyesBridge = new ExternalInterfaceBridge(root);
    }

    private static const POLL_INTERVAL : int = 200;

    private var _poller : Timer;

    private var _pollStart : Date;

    public function pollExternalInterface() : void
    {
        _poller = new Timer(POLL_INTERVAL);
        _poller.addEventListener(TimerEvent.TIMER, onPollTimer);
        _poller.start();
        _pollStart = new Date();
        status = "polling started";
    }

    private function onPollTimer(event:TimerEvent):void
    {

        if(new Date().time - _pollStart.time > 5000)
        {
            status = "timeout calling external interface ACK";
            throw new Error("Timeout calling external interface ACK");
        }
        if(ExternalInterface.available)
        {
            ExternalInterface.addCallback("flashTestSuite_robotEyesScript", callRobotEyesScript);
            ExternalInterface.marshallExceptions = true;

            try
            {
                status = "external interface call";
                var available : * = ExternalInterface.call('window.testFlashSuiteACK');
                status = "external interface result = " + available;
                if(available)
                {
                    _poller.stop();
                    status = "external interface result = " + available + ", stop poll";
                }
            }
            catch(e:Error)
            {
                status = e.getStackTrace();
            }
        }
        else
        {
            status = "external interface not available";
        }

    }

    private function callRobotEyesScript(script:String) : *
    {
        return _robotEyesBridge.execute(script);
    }
}
}
