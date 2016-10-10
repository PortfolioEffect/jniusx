.. _quickstart:

Quickstart
==========

Eager to get started? This page will give you a good introduction to Jniusx. It assumes
you have already Jniusx installed. If you do not, head over the
:ref:`installation` section.

A minimal example
-----------------

A minimal Jniusx example looks something like this::

    from jniusx import autoclass

    Stack = autoclass('java.util.Stack')
    stack = Stack()
    stack.push('hello')
    stack.push('world')

    print stack.pop() # --> 'world'
    print stack.pop() # --> 'hello'

Just save it as `test.py` (or something similar) and run it with your Python
interpreter. Make sure not to call your application `jniusx.py` because it would
conflict with Jniusx itself::

    $ python test.py
    world
    hello

Automatic recursive inspection
------------------------------

Jniusx uses Java reflection to give you a new autoclass() if the return type is
not a native type. Let's see this example::

    System = autoclass('java.lang.System')
    System.out.println('Hello World')

We only declared the first System class, but we are able to use all the static
fields and methods naturally. Let's go deeper::

    >>> System = autoclass('java.lang.System')
    >>> System
    <class 'jniusx.java.lang.System'>
    >>> System.out
    <java.io.PrintStream at 0x234df50 jclass=java/io/PrintStream jself=37921360>
    >>> System.out.println
    <jniusx.JavaMethodMultiple object at 0x236adb8>

The recursive reflection always gives you an appropriate object that reflects the
returned Java object.
