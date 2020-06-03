A minimal VPN
================================

This is a minimal QML c++/go VPN application.

Cross-compilation
-----------------

Cross-compilation is done using mxe. You should have the mxe cloned and have
built the toolchain in the parent folder. Then you can build for windows like
this:

```
XBUILD=win64 ./build.sh
```

You should see the binary in `release/MinimalQml.exe`.

Dependencies
------------------
besides the basic qt5 libraries, the following packages are needed:

* qml-module-qt-labs-platform

TODO
------------------

* [ ] check status of qt-labs-platform in mxe
* [ ] provide Vagrantfile (or Dockerfile) with mxe toolchain pre-installed.
* [ ] document quirks on complation of the toolchain
* [ ] explore qtquick deployment "the qt way" 
  * [ ] https://doc.qt.io/qt-5/qtquick-deployment.html
  * [ ] windeployqt? if this works for UWP, that'd be super nice https://doc.qt.io/qt-5/windows-deployment.html *"The Windows deployment tool windeployqt is designed to automate the process of creating a deployable folder containing the Qt-related dependencies (libraries, QML imports, plugins, and translations) required to run the application from that folder. It creates a sandbox for Universal Windows Platform (UWP) or an installation tree for Windows desktop applications, which can be easily bundled into an installation package."*
