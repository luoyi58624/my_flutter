# mowork app for flutter

- 生成app图标

> flutter pub run flutter_launcher_icons:main

- 打包apk（android，不要使用，安卓需要区分环境，执行最下面的命令）

> flutter build apk
> flutter build apk --target-platform android-arm64

- 打包ipa（ios -> app-store包，上架应用商店）

> flutter build ipa --release

- 打包ipa（ios -> ad-hoc包，给测试机型使用）

> flutter build ipa --release --export-method=ad-hoc

- 安装打包好的app

> flutter install

- 在谷歌浏览器上运行

> flutter run -d chrome --web-renderer html --flavor prod -t lib/main_prod.dart

- 打包和安装指定环境的app（仅限android）

> flutter build apk --flavor dev -t lib/main_dev.dart --target-platform android-arm64
> flutter install --use-application-binary build/app/outputs/flutter-apk/app-dev-release.apk

> flutter build apk --flavor prod -t lib/main_prod.dart --target-platform android-arm64
> flutter install --use-application-binary build/app/outputs/flutter-apk/app-prod-release.apk