#!/bin/bash

git clone https://github.com/flutter/flutter.git
export PATH=$PATH:./flutter/bin:./flutter/bin/cache/dart-sdk/bin

flutter channel stable
flutter config --enable-web

flutter build web --web-renderer canvaskit --release
