from __future__ import print_function
from __future__ import division
from __future__ import absolute_import
import unittest
from jniusx.reflect import autoclass

class BasicsTest(unittest.TestCase):

    def test_static_methods(self):
        ClassArgument = autoclass('org.jniusx.ClassArgument')
        self.assertEquals(ClassArgument.getName(ClassArgument), 'class org.jniusx.ClassArgument')
