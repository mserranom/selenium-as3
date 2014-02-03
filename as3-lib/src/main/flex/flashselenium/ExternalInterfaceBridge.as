package flashselenium
{
import flash.display.DisplayObjectContainer;

import flashselenium.sjs.Interpreter;

import flashselenium.viewspy.ViewSpy;

public class ExternalInterfaceBridge
{

    private var _root : DisplayObjectContainer;

    public function ExternalInterfaceBridge(root:DisplayObjectContainer)
    {
        this._root = root;
    }

    public function execute(script : String) : *
    {

        const interpreter : Interpreter = new Interpreter();

        const params : Object = {
            root : new ViewSpy(_root)
        };

        interpreter.pushDict(params);
        interpreter.load("var __res = root." + script + ";");
        interpreter.run();

        const retValue : * = interpreter.vm.findVar("__res");
        return retValue;
    }

}
}
