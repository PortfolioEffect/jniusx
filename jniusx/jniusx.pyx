
'''
Java wrapper
============

With this module, you can create Python class that reflects a Java class, and use
it directly in Python.

Example with static method
--------------------------

Java::

    package org.test;
    public class Hardware {
        static int getDPI() {
            return metrics.densityDpi;
        }
    }

Python::

    class Hardware(JavaClass):
        __metaclass__ = MetaJavaClass
        __javaclass__ = 'org/test/Hardware'
        getDPI = JavaStaticMethod('()I')

    Hardware.getDPI()


Example with instance method
----------------------------

Java::

    package org.test;
    public class Action {
        public String getName() {
            return new String("Hello world")
        }
    }

Python::

    class Action(JavaClass):
        __metaclass__ = MetaJavaClass
        __javaclass__ = 'org/test/Action'
        getName = JavaMethod('()Ljava/lang/String;')

    action = Action()
    print action.getName()
    # will output Hello World


Example with static/instance field
----------------------------------

Java::

    package org.test;
    public class Test {
        public static String field1 = new String("hello");
        public String field2;

        public Test() {
            this.field2 = new String("world");
        }
    }

Python::

    class Test(JavaClass):
        __metaclass__ = MetaJavaClass
        __javaclass__ = 'org/test/Test'

        field1 = JavaStaticField('Ljava/lang/String;')
        field2 = JavaField('Ljava/lang/String;')

    # access directly to the static field
    print Test.field1

    # create the instance, and access to the instance field
    test = Test()
    print test.field2

'''

__all__ = ('JavaObject', 'JavaClass', 'JavaMethod', 'JavaField',
           'MetaJavaClass', 'JavaException', 'cast', 'find_javaclass',
           'PythonJavaClass', 'java_method', 'detach')

from libc.stdlib cimport malloc, free
from functools import partial
import sys
import traceback

include "jni.pxi"
include "config.pxi"

IF JNIUS_PLATFORM == "android":
    include "jniusx_jvm_android.pxi"
ELIF JNIUS_PLATFORM == "win32":    
    include "jniusx_jvm_desktop.pxi"
ELSE:
    include "jniusx_jvm_dlopen.pxi"

include "jniusx_env.pxi"
include "jniusx_utils.pxi"
include "jniusx_conversion.pxi"
include "jniusx_localref.pxi"
IF JNIUS_PYTHON3:
    include "jniusx_nativetypes3.pxi"
ELSE:    
    include "jniusx_nativetypes.pxi"

include "jniusx_export_func.pxi"
include "jniusx_export_class.pxi"

include "jniusx_proxy.pxi"
