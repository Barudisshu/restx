package {package};

import restx.factory.*;
import {moduleFqcn};


@Machine
public class {machine} extends DefaultFactoryMachine {
    private static final {moduleType} module = new {moduleType}();

    public {machine}() {
        super(0,
{providers}
        );
    }
}
