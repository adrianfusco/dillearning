#!/usr/bin/env bash

set -euo pipefail

install_dependencies() {
    echo "Instalando dependencias: "
    apt-get update -y && apt-get install -y --no-install-recommends \
        clang cmake ninja-build pkg-config libgtk-3-dev dpkg-dev
}

build_flutter_project() {
    echo "Creando binario dillearning en Flutter: "
    pushd dillearning
    flutter clean
    flutter pub get
    flutter build linux --release
    popd
}

create_debian_package() {
    echo 'Creadno paquete .deb: '
    local VERSION=$(grep 'version:' dillearning/pubspec.yaml | cut -d ' ' -f 2 | cut -d '+' -f 1)
    local DEB_DIR=build/deb
    local STAGING_DIR=$DEB_DIR/dillearning

    rm -rf $DEB_DIR
    mkdir -p $STAGING_DIR/DEBIAN
    mkdir -p $STAGING_DIR/opt/dillearning
    mkdir -p $STAGING_DIR/usr/bin
    mkdir -p $STAGING_DIR/usr/share/applications
    mkdir -p $STAGING_DIR/usr/share/icons/hicolor/512x512/apps

    cp ./scripts/files/deb/control $STAGING_DIR/DEBIAN/control
    sed -i "s/%%VERSION%%/$VERSION/" $STAGING_DIR/DEBIAN/control

    cp ./scripts/files/deb/launcher.sh $STAGING_DIR/usr/bin/dillearning
    chmod 755 $STAGING_DIR/usr/bin/dillearning

    cp ./scripts/files/deb/app.desktop $STAGING_DIR/usr/share/applications/dillearning.desktop
    cp -r dillearning/build/linux/x64/release/bundle/* $STAGING_DIR/opt/dillearning/
    cp dillearning/web/icons/Icon-512.png $STAGING_DIR/usr/share/icons/hicolor/512x512/apps/dillearning.png

    dpkg-deb --build $STAGING_DIR
    mv $DEB_DIR/dillearning.deb "dillearning/build/linux/x64/release/bundle/dillearning-$VERSION-amd64.deb"
    echo 'Paquete .deb creado'
}

main() {
    install_dependencies
    build_flutter_project
    create_debian_package
}

main