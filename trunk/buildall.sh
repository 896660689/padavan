#!/bin/bash
# by HuangYingNing at gmail.not.mail.me

cwd=`dirname $0`
pushd ${cwd}
cwd=`pwd`
mkdir -p ${cwd}/images/
CONFIG_TOOLCHAIN_DIR=${cwd//\//\\\/}\\/toolchain-mipsel

function moreFeatures()
{
	sed -i 's/#CONFIG_FIRMWARE_INCLUDE_MINIDLNA=y/CONFIG_FIRMWARE_INCLUDE_MINIDLNA=y/g' .config
	echo "### free x/y/zmodem implementation. ~0.05MB" >> .config
	echo "CONFIG_FIRMWARE_INCLUDE_LRZSZ=y" >> .config
}

function lessFeatures()
{
	# 固件大于8M，去掉OpenVPN等,压缩到7.68MB
	sed -i 's/CONFIG_FIRMWARE_ENABLE_EXT4=y/#CONFIG_FIRMWARE_ENABLE_EXT4=y/g' .config
	sed -i 's/CONFIG_FIRMWARE_ENABLE_FUSE=y/#CONFIG_FIRMWARE_ENABLE_FUSE=y/g' .config
#	sed -i 's/CONFIG_FIRMWARE_INCLUDE_IPSET=y/#CONFIG_FIRMWARE_INCLUDE_IPSET=y/g' .config
	sed -i 's/CONFIG_FIRMWARE_INCLUDE_EAP_PEAP=y/#CONFIG_FIRMWARE_INCLUDE_EAP_PEAP=y/g' .config
	sed -i 's/CONFIG_FIRMWARE_INCLUDE_DDNS_SSL=y/#CONFIG_FIRMWARE_INCLUDE_DDNS_SSL=y/g' .config
	sed -i 's/CONFIG_FIRMWARE_INCLUDE_HTTPS=y/#CONFIG_FIRMWARE_INCLUDE_HTTPS=y/g' .config
	sed -i 's/CONFIG_FIRMWARE_INCLUDE_OPENVPN=y/#CONFIG_FIRMWARE_INCLUDE_OPENVPN=y/g' .config
	sed -i 's/CONFIG_FIRMWARE_INCLUDE_OPENSSL_EXE=y/#CONFIG_FIRMWARE_INCLUDE_OPENSSL_EXE=y/g' .config
	echo "### free x/y/zmodem implementation. ~0.05MB" >> .config
	echo "CONFIG_FIRMWARE_INCLUDE_ADBYBY=y" >> /opt/rt-n56u/trunk/configs/templates/K2P.config
}

function configFirmware()
{
	templates=$1
	board_dir=$2
	board_name=$3
	cp -f ${templates} .config
	sed -i "s/^CONFIG_FIRMWARE_PRODUCT_ID=.*$/CONFIG_FIRMWARE_PRODUCT_ID=\"${board_name}\"/g" .config
	sed -i "s/^CONFIG_TOOLCHAIN_DIR=.*$/CONFIG_TOOLCHAIN_DIR=${CONFIG_TOOLCHAIN_DIR}/g" .config
	if [ "`realpath ${board_dir}`" != "`realpath configs/boards/${board_name}`" ]; then
		rm -rf configs/boards/${board_name}
		cp -r ${board_dir} configs/boards/${board_name}
	fi
}

function buildFirmware()
{
	sed -i 's/\r$//' .config
	sudo ./clear_tree
	sudo ./build_firmware_modify $1
	sudo mv -f images/*.trx ${cwd}/images/
}


if [ "$1" = "" ] || [ "$1" = "init" ]; then
	pushd toolchain-mipsel
	sudo ./clean_sources
	sudo ./build_toolchain
	popd
fi

# build
pushd trunk
# for K2P-5.0
if [ "$1" = "" ] || [ "$1" = "K2P-5.0" ]; then
	echo build K2P-5.0 firmware...
	temp="K2P-5.0"
	sed -i '/CONFIG_FIRMWARE_INCLUDE_ADBYBY/d' configs/templates/${temp}.config
	sed -i '/CONFIG_FIRMWARE_INCLUDE_PDNSD/d' configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_ADBYBY=y" >> configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_PDNSD=y" >> configs/templates/${temp}.config
	#moreFeatures
	buildFirmware K2P-5.0
fi

if [ "$1" = "" ] || [ "$1" = "K2P-USB-5.0" ]; then
	echo build K2P-USB-5.0 firmware...
	temp="K2P-USB-5.0"
	sed -i '/CONFIG_FIRMWARE_INCLUDE_ADBYBY/d' configs/templates/${temp}.config
	sed -i '/CONFIG_FIRMWARE_INCLUDE_PDNSD/d' configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_ADBYBY=y" >> configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_PDNSD=y" >> configs/templates/${temp}.config
	#moreFeatures
	buildFirmware K2P-USB-5.0
fi

# for NEWIFI-MINI
if [ "$1" = "" ] || [ "$1" = "NEWIFI-MINI" ]; then
	echo build NEWIFI-MINI firmware...
	temp="NEWIFI-MINI"
	sed -i '/CONFIG_FIRMWARE_INCLUDE_ADBYBY/d' configs/templates/${temp}.config
	sed -i '/CONFIG_FIRMWARE_INCLUDE_PDNSD/d' configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_ADBYBY=y" >> configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_PDNSD=y" >> configs/templates/${temp}.config
	#moreFeatures
	buildFirmware NEWIFI-MINI
fi

# for NEWIFI3
if [ "$1" = "" ] || [ "$1" = "NEWIFI3" ]; then
	echo build NEWIFI3 firmware...
	temp="NEWIFI3"
	sed -i '/CONFIG_FIRMWARE_INCLUDE_ADBYBY/d' configs/templates/${temp}.config
	sed -i '/CONFIG_FIRMWARE_INCLUDE_PDNSD/d' configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_ADBYBY=y" >> configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_PDNSD=y" >> configs/templates/${temp}.config
	#moreFeatures
	buildFirmware NEWIFI3
fi

# for MI-3
if [ "$1" = "" ] || [ "$1" = "MI-3" ]; then
	echo build MI-3 firmware...
	temp="MI-3"
	sed -i '/CONFIG_FIRMWARE_INCLUDE_ADBYBY/d' configs/templates/${temp}.config
	sed -i '/CONFIG_FIRMWARE_INCLUDE_PDNSD/d' configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_ADBYBY=y" >> configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_PDNSD=y" >> configs/templates/${temp}.config
	#moreFeatures
	buildFirmware MI-3
fi

# for MI-MINI
if [ "$1" = "" ] || [ "$1" = "MI-MINI" ]; then
	echo build MI-MINI firmware...
	temp="MI-MINI"
	sed -i '/CONFIG_FIRMWARE_INCLUDE_ADBYBY/d' configs/templates/${temp}.config
	sed -i '/CONFIG_FIRMWARE_INCLUDE_PDNSD/d' configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_ADBYBY=y" >> configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_PDNSD=y" >> configs/templates/${temp}.config
	#moreFeatures
	buildFirmware MI-MINI
fi

# for 360P2
if [ "$1" = "" ] || [ "$1" = "360P2" ]; then
	echo build 360P2 firmware...
	temp="360P2"
	sed -i '/CONFIG_FIRMWARE_INCLUDE_ADBYBY/d' configs/templates/${temp}.config
	sed -i '/CONFIG_FIRMWARE_INCLUDE_PDNSD/d' configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_ADBYBY=y" >> configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_PDNSD=y" >> configs/templates/${temp}.config
	#moreFeatures
	buildFirmware 360P2
fi

# for WR1200JS
if [ "$1" = "" ] || [ "$1" = "WR1200JS" ]; then
	echo build WR1200JS firmware...
	temp="WR1200JS"
	sed -i '/CONFIG_FIRMWARE_INCLUDE_ADBYBY/d' configs/templates/${temp}.config
	sed -i '/CONFIG_FIRMWARE_INCLUDE_PDNSD/d' configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_ADBYBY=y" >> configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_PDNSD=y" >> configs/templates/${temp}.config
	#moreFeatures
	buildFirmware WR1200JS
fi

# for DIR-878-5.0
if [ "$1" = "" ] || [ "$1" = "DIR-878-5.0" ]; then
	echo build DIR-878-5.0 firmware...
	temp="DIR-878-5.0"
	sed -i '/CONFIG_FIRMWARE_INCLUDE_ADBYBY/d' configs/templates/${temp}.config
	sed -i '/CONFIG_FIRMWARE_INCLUDE_PDNSD/d' configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_ADBYBY=y" >> configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_PDNSD=y" >> configs/templates/${temp}.config
	#moreFeatures
	buildFirmware DIR-878-5.0
fi

# for DIR-882-5.0
if [ "$1" = "" ] || [ "$1" = "DIR-882-5.0" ]; then
	echo build DIR-882-5.0 firmware...
	temp="DIR-882-5.0"
	sed -i '/CONFIG_FIRMWARE_INCLUDE_ADBYBY/d' configs/templates/${temp}.config
	sed -i '/CONFIG_FIRMWARE_INCLUDE_PDNSD/d' configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_ADBYBY=y" >> configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_PDNSD=y" >> configs/templates/${temp}.config
	#moreFeatures
	buildFirmware DIR-882-5.0
fi

# for DIR-882-5.0
if [ "$1" = "" ] || [ "$1" = "DIR-882-5.0" ]; then
	echo build DIR-882-5.0 firmware...
	temp="DIR-882-5.0"
	sed -i '/CONFIG_FIRMWARE_INCLUDE_ADBYBY/d' configs/templates/${temp}.config
	sed -i '/CONFIG_FIRMWARE_INCLUDE_PDNSD/d' configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_ADBYBY=y" >> configs/templates/${temp}.config
	echo "CONFIG_FIRMWARE_INCLUDE_PDNSD=y" >> configs/templates/${temp}.config
	#moreFeatures
	buildFirmware DIR-882-5.0
fi


echo `date` 完成！

popd

popd


