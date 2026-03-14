# zed-qml
QML language support for Zed

![Bildschirmfoto_20240704_193955](https://github.com/lkroll/zed-qml/assets/24440161/f9b4893c-3927-4cef-a57c-58ae004ab9f6)

## Features

By leveraging [qml-js tree-sitter](https://github.com/yuja/tree-sitter-qmljs),
the extension provides:

- Syntax highlighting (including JS used in QML files)
- Outline support for UI components and functions
- Automatic indenting and auto closing brackets, strings etc.

## Installation

zed-qml is available in the Extension Gallery.
See [Zed documentation](https://zed.dev/docs/extensions/installing-extensions) for more info.

## Dependencies

### QML Language Server (qmlls)

The `qmlls` binary should be installed locally from your Qt install.

#### MacOS

Make sure you have `qmlls` available in your `$PATH`. If you have installed Qt using the online installer you may need to do that manually.

The simplest way to achieve that is by adding this line at the end of your .zshrc file:

```bash
export PATH=$PATH:/Users/$USER/Qt/6.8.0/macos/bin
```

This assumes the version of Qt you have installed is 6.8.0.

#### Linux

On Linux in most cases you can just install qmlls by using your package manger.

##### Ubuntu

```bash
sudo apt install qt6-declarative-dev-tools
```

##### Fedora

```bash
sudo dnf install qt6-qtdeclarative-devel
```

##### Arch

```bash
sudo pacman -S qt6-declarative
```

##### Void Linux

```bash
sudo xbps-install qt6-declarative-tools
```

Void installs `qmlls` to `/usr/lib/qt6/bin/qmlls` so you either need to symlink it to `/usr/bin/qmlls` or just add it to your `$PATH` like so:

```bash
echo "export PATH=\$PATH:/usr/lib/qt6/bin" >> ~/.bashrc
```

## Language Server Configuration

See [Qt documentation](https://doc.qt.io/qt-6/qtqml-tooling-qmlls.html) for configuration.

### Extra Arguments

For qmlls to recognize modules in your `QML_IMPORT_PATH`, you can add the `-E` argument to your Zed settings like so:

```json
{
  "lsp": {
    "qml": {
      "binary": {
        "arguments": ["-E", "additional-args"]
      }
    }
  }
}
```

### Configure Build Directory

For qmlls to recognize your QML modules, you have to specify the build directory of your project.
The simplest way to do that is by specifying it in a file called `.qmlls.ini` in your project root like so:

```ini
[General]
buildDir=path/to/build/dir
```

Then after building your project once all errors regarding "module not found" should be resolved.
