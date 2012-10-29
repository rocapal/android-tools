APKDecompile
=============

Decompile your APK files (Android apps) to see source code and xml files.

Description
------------

Decompile is a process to revert the compile operation. I main,
decompile converts the low level code in high level code. The Android
application is compiled in APK container that groups files as: xml,
images and class. APK containers are actually ZIP containers. An
interest thing is can see the xml configuration or some source code of
others applications or check what sensible data of your application
can be seen by others.


Tools
-----

APKDecompile helps you to decompile an APK file
to see xml configuration and source code. APKDecompile uses the
following tools:

* APKTool: Decompile all the configuration XML and resources as
images. It's great to view AndroidManifest.xml or some layout xml. The
source code is decompiled to "smali". This assembler language is based
in dalvik but it's not translate to JAVA.

* dex2jar: If we unzip the APK file we find a .dex files. This tools
translate .dex file to JAR file with all the class files of the
project. So, you can use any class2java decompiler to view source code

* JAD Java Decompiler: It's widely used through command line and very
useful to make scripts by automatic process

* JDGUI: Graphic decompiler and integrated with eclipse. It's not an
efficient solution to run process in background. Currently, I’m
interesting in decompile Android applications because I want to know
the data imported/exported by them. And this is possible if I can
analyze the AndroidManifest.xml and the source code.


License
-------

Usage
-----

	./APKDecompile.sh application.apk /tmp/results



