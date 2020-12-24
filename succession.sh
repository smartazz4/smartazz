#!/bin/bash
# Define user variables, which the user can change by passing parameters to "succession.sh"

$ShouldUseCurl
$ShouldEraseDevice
$SetLocation
$SetLogLocation
$ShouldRestoreDevice
$SetVerbose
# We need to see what the user has passed to "succession.sh"
while [ $# -gt 0 ] ; do
  case $1 in
    -c | --use-curl) C="$2"
# Change the variable
	ShouldUseCurl=true
# This is only here for debugging, it should be removed later
echo use curl
echo ShouldUseCurl = $ShouldUseCurl
;;
    -e | --erase) E="$2"
# Change the variable
	ShouldEraseDevice=true
	#This is for debugging only, it should be removed later 
echo erase device
echo ShouldEraseDevice = $ShouldEraseDevice
;;
    -h | --help) H="$2"
# create a function called "ShowHelp"
ShowHelp ()
{
echo usage:

echo "-c (--use-curl) (use curl rather than partial zip)"
echo "-e (--erase) (erase the device, remove all user data)"
echo "-l (--location) (specify the location of the ipsw or dmg) defaults to /var/mobile/Media/Succession)"
echo "-L (--set-log-location) (specify where   succession's log should go)"
echo "-r (--restore) (restore the root filesystem (rootfs) keep user data)"
echo "-v (--verbose) (be verbose)"
exit
}
ShowHelp
;;
    -l | --location) L="$2"
# SetLocation is the second parameter as we want to see the file the user provides  
	SetLocation=$2
	
echo file location is  $SetLocation
# Check if the user has provided an IPSW and move it to the succession folder
 if [[ -f $SetLocation ]];
then

if [ "${SetLocation: -5}" == ".ipsw" ];
then 
mv $SetLocation /var/mobile/Media/Succession/ipsw.ipsw
# We no longer need to download the IPSW, but we need to extract it 
#ShouldDownloadIPSW=false
#ShouldExtractIPSW=true
echo the ipsw has been moved successfully
# If the file the user provides is a DMG 
elif [ "${SetLocation: -4}" == ".dmg" ];
then 
mv $SetLocation /var/mobile/Media/Succession/rfs.dmg
# We don't need to download or extract the DMG 
$ShouldDownloadIPSW=false
$ShouldExtractIPSW=false
echo the dmg  has been moved successfully 
else
echo this is not a valid file format
exit
fi
fi
;;
    -L | --set-log-location) L="$2"
	# Specify where the log should be written to
	SetLogLocation=$2	
	# This is for debugging purposes, it should be removed in the Final release 
	echo $SetLogLocation
	;;
    -r | --restore) r="$2"
# Change the variable 	
ShouldRestoreDevice=true
# This is for debugging purposes only, it should be removed in the final build
echo will restore device
echo should restore device is    $ShouldRestoreDevice
;;
    -v | --verbose) V="$2"
	# change variable
	SetVerbose=true
	# This is only for debugging purposes, it should be removed in the final build 	
	
echo will be verbose
echo SetVerbose = $SetVerbose 
;;
  esac
  shift
done
#echo $C $E $H $L $R $V
#declare the current version of Succession here
CurrentSuccessionCLIVersion="1.0~alpha1"

#Text ending is presented by =\e[0m"
#Red Text is presented by "\e[1;31m
#Green text is presented by "\e[1;32m`

if [ ! -f /usr/bin/SuccessionCLIhelper ]; then
echo -e "\e[1;31mIt looks like a component of SuccessionCLI is missing, please reinstall succession and do not modify any files\e[1;31m"  
exit
fi
mkdir -p /private/var/mobile/Media/Succession/
curl --silent https://raw.githubusercontent.com/Samgisaninja/samgisaninja.github.io/master/motd-cli.plist -o /private/var/mobile/Media/Succession/motd.plist -k
shouldIRun=`SuccessionCLIhelper --shouldIRun`
remoteMessage=`SuccessionCLIhelper --getMOTD`
if [[ $remoteMessage != "No MOTD" ]]; then
    echo $remoteMessage
    rm /private/var/mobile/Media/Succession/motd.plist
fi
if [[ $shouldIRun == "false" ]]; then
    echo -e "\e[1;31mFor your safety, Succession has been remotely disabled. Please try again at a later time.\e[0m"
    rm /private/var/mobile/Media/Succession/motd.plist
    exit 0
fi
curl -L --silent https://raw.githubusercontent.com/Samgisaninja/samgisaninja.github.io/master/SuccessionCLIVersion.txt -o /private/var/mobile/Media/Succession/LatestSuccessionCLIVersion.txt -k
LatestSuccessionCLIVersion=`head -1 /private/var/mobile/Media/Succession/LatestSuccessionCLIVersion.txt`
if [ "$LatestSuccessionCLIVersion" != "$CurrentSuccessionCLIVersion" ]; 
then
echo -e "\e[1;31mThe current version of Succession that you are running is $CurrentSuccessionCLIVersion however, the latest version of SuccessionCLI is $LatestSuccessionCLIVersion: we strongly suggest that you  update through either your package manager or by visiting SuccessionCLI’s github page at https://github.com/Samgisaninja/SuccessionRestore/tree/SuccessionCLI\e[0m"
#add the ability to directly update from here in the future
fi  
echo -e "\e[1;32mWelcome to SuccessionCLI! Written by Samg_is_a_Ninja and Hassan’s Tech (demhademha)\e[0m"
echo -e "\e[1;32mSpecial thanks to pwn20wnd (mountpoint and rsync args) and shmoopi (for iOS System Services)\e[0m"
echo -e "\e[1;32mIf you found this tool useful, then consider donating to demhademha at https://www.paypal.me/demhademha and to Samg_is_a_Ninja at     
https://www.paypal.me/SamGardner4 In addition, you can visit https://github.com/Samgisaninja/SuccessionRestore/tree/SuccessionCLI to get support\e[0m" 
sleep 3
checkRoot=`whoami`
if [ $checkRoot != "root" ]; then
    echo -e "\e[1;31mSuccessionCLI needs to be run as root. Please \"su\" and try again. Alternatively, try \"ssh root@[IP Address]\"\e[0m"
    exit
fi
#Contact helper tool to get iOS version and device model
ProductVersion=`SuccessionCLIhelper --deviceVersion`
#we are now going to get the product buildversion for example, 17c54 and set it as a variable   
ProductBuildVersion=`SuccessionCLIhelper --deviceBuildNumber`
#we now get the machine ID, (for example iPhone9,4), and store it as a variable
DeviceIdentifier=`SuccessionCLIhelper --deviceModel`
#we now need to get the actual device identifier for example, iPad 7,11 is iPad 7th generation 
curl --silent 'https://api.ipsw.me/v4/devices' -o /private/var/mobile/Media/Succession/devices.json -k
DeviceName=`SuccessionCLIhelper --deviceCommonName`
FreeSpace=`SuccessionCLIhelper --freeSpace`
rm /private/var/mobile/Media/Succession/devices.json
#We’ll print these values that we have retrieved  
echo ""
echo -e "\e[1;32mYour $DeviceIdentifier aka $DeviceName is running iOS version $ProductVersion build $ProductBuildVersion\e[0m"
if [[ $ProductVersion == "9"* ]]; then
    if [[ $DeviceIdentifier == "iPhone8,1" ]] || [[ $DeviceIdentifier == "iPhone8,2" ]]; then
        echo -e "\e[1;31mSuccession is disabled: the iPhone 6s cannot be activated on iOS 9.\e[0m"
    fi
fi
needsDecryptionString=`SuccessionCLIhelper --needsDecryption`
if [[ $needsDecryptionString == "TRUE" ]]; then
	needsDecryption=true
	if [ ! -f /usr/bin/dmg ]; then
		echo -e "\e[1;31mError! You need to install \"XPwn\" to continue. Please search and install XPwn in your package manager.\e[0m"
		exit 0
	fi
else
	needsDecryption=false
fi
rm /private/var/mobile/Media/Succession/motd.plist
echo -e "\e[1;32mPlease make sure this information is accurate before continuing. Press enter to confirm or exit by pressing control + c if inaccurate.\e[0m"
read varblank
shouldExtractIPSW=true
shouldDownloadIPSW=true

if [ -f /private/var/mobile/Media/Succession/partial.ipsw ]; then
    while true; do
        read -p $'\e[1;32mIt looks that a previous IPSW download was interrupted! Would you like to continue the download? (y/n) \e[0m' yn
        case $yn in
            [Yy]* ) curl -# -L -C - https://api.ipsw.me/v4/ipsw/download/$DeviceIdentifier/$ProductBuildVersion -o /private/var/mobile/Media/Succession/partial.ipsw -k

shouldExtractIPSW=true
shouldDownloadIPSW=false; break;;
            [Nn]* ) shouldExtractIPSW=true; break;;
            * ) echo -e "\e[1;31mPlease answer yes or no.\e[0m";;
        esac
    done
fi

if [ -f /private/var/mobile/Media/Succession/rfs.dmg ]; then
    while true; do
        read -p $'\e[1;32mDetected provided rootfilesystem disk image, would you like to use it? (y/n) \e[0m' yn
        case $yn in
            [Yy]* ) shouldExtractIPSW=false; break;;
            [Nn]* ) shouldExtractIPSW=true; break;;
            * ) echo -e "\e[1;31mPlease answer yes or no.\e[0m";;
        esac
    done
fi
if ! $shouldExtractIPSW; then
    rm -rf /private/var/mobile/Media/Succession/ipsw*
    shouldDownloadIPSW=false
fi
if [ -f /private/var/mobile/Media/Succession/*.ipsw ]; then
    while true; do
        read -p $'\e[1;32mDetected provided ipsw, would you like to use it? (y/n) \e[0m' yn
        case $yn in
            [Yy]* ) shouldDownloadIPSW=false; break;;
            [Nn]* ) shouldDownloadIPSW=true; break;;
            * ) echo -e "\e[1;31mPlease answer yes or no.\e[0m";;
        esac
    done
fi

if $shouldDownloadIPSW; then 

	#we need to get the size of the IPSW, to ensure that the user has enough storage
	#we now read the size of the IPSW
	IPSWFileSize=`curl --silent -L http://api.ipsw.me/v2.1/$DeviceIdentifier/$ProductBuildVersion/filesize -k`
	if (( $IPSWFileSize > $FreeSpace )); then
		while true; do
    	    read -p $'\e[1;31mIt appears you don\'t have enough storage to download the IPSW. Would you like to override this check?  (y/n) \e[0m' yn
        	case $yn in
            	[Yy]* ) break;;
            	[Nn]* ) exit; break;;
            	* ) echo -e "\e[1;31mPlease answer yes or no.\e[0m";;
        	esac
    	done
	fi
 	echo -e "\e[1;32mSuccession will download the correct IPSW for your device\e[0m"
    #print a warning message 
    echo -e "\e[1;32mOnce you press enter again, Succession will begin the download\e[0m"  
    echo -e "\e[1;32mDO NOT LEAVE TERMINAL\e[0m"
    echo -e "\e[1;32mDO NOT POWER OFF YOUR DEVICE\e[0m" 
    echo -e "\e[1;32mPress enter to proceed\e[0m" 
    read varblank2
  	echo -e "\e[1;32mDownloading IPSW...\e[0m" 
    # Clean up any files from previous runs
    rm -rf /private/var/mobile/Media/Succession/*
    #we download the ipsw from apple’s servers through ipsw.me’s api
    #TODO: add pzb to just download what we need instead of the entire IPSW
    
	curl  -# -L -o /private/var/mobile/Media/Succession/partial.ipsw https://api.ipsw.me/v4/ipsw/download/$DeviceIdentifier/$ProductBuildVersion -k
	#now that the download is complete, rename "partial.ipsw" to "ipsw.ipsw"
	mv /private/var/mobile/Media/Succession/partial.ipsw /private/var/mobile/Media/Succession/ipsw.ipsw
	#make the user confirm  that they want to extract the IPSW
	echo -e "\e[1;32mThe IPSW has successfully downloaded, please press enter to extract it"
	read varblank3
fi
if $shouldExtractIPSW; then
    #we create a new directory to put the ipsw that is going to be extracted   
    # Clean up partially extracted ipsws from previous runs
    rm -rf /private/var/mobile/Media/Succession/ipsw/*
    # If this is the first run, we need a destination folder to dump to
    mkdir -p /private/var/mobile/Media/Succession/ipsw/
    #let's rename the ipsw file as it could be called anything!
    mv /private/var/mobile/Media/Succession/*.ipsw /private/var/mobile/Media/Succession/ipsw.ipsw
    echo -e "\e[1;32mVerifying IPSW...\e[0m"
    /usr/bin/successionclitools/lib/p7zip/7z x /private/var/mobile/Media/Succession/ipsw.ipsw -o/var/mobile/Media/Succession BuildManifest.plist -r

buildManifestString=$(</private/var/mobile/Media/Succession/BuildManifest.plist)
    if grep -q "$ProductBuildVersion" "/private/var/mobile/Media/Succession/BuildManifest.plist"; then
        echo -e "\e[1;32mIPSW verified, extracting root filesystem...\e[0m"
        nameOfDMG=`/usr/bin/successionclitools/lib/p7zip/7z l /private/var/mobile/Media/Succession/ipsw.ipsw | grep "dmg" | sort -k 4 | awk 'END {print $NF}'`
        /usr/bin/successionclitools/lib/p7zip/7z x /private/var/mobile/Media/Succession/ipsw.ipsw -o/var/mobile/Media/Succession $nameOfDMG -r
mv /private/var/mobile/Media/Succession/$nameOfDMG /private/var/mobile/Media/Succession//encrypted.dmg
    else
    versionCheckOverride=false
        echo -e "\e[1;31m**********WARNING!**********\e[0m"
        echo -e "\e[1;31mThe IPSW provided does not appear to match the iOS version of this device\e[0m"
        echo -e "\e[1;31mATTEMPTING TO CHANGE YOUR iOS VERSION USING THIS TOOL WILL RESULT IN A BOOTLOOP\e[0m"
        while true; do
            read -p $'\e[1;31mWould you like to override this check and continue anyway? (y/n) \e[0m' yn
                case $yn in
                [Yy]* ) versionCheckOverride=true; break;;
                [Nn]* ) versionCheckOverride=false; break;;
                * ) echo -e "\e[1;31mPlease answer yes or no.\e[0m";;
            esac
        done
        if [[ $versionCheckOverride = "true" ]];
then
                echo -e "\e[1;31mVersion check overridden, continuing as if nothing went wrong...\e[0m"
        nameOfDMG=`/usr/bin/successionclitools/lib/p7zip/7z l /private/var/mobile/Media/Succession/ipsw.ipsw | grep "dmg" | sort -k 4 | awk 'END {print $NF}'`
        /usr/bin/successionclitools/lib/p7zip/7z x /private/var/mobile/Media/Succession/ipsw.ipsw -o/var/mobile/Media/Succession $nameOfDMG -r
mv /private/var/mobile/Media/Succession/$nameOfDMG /private/var/mobile/Media/Succession//encrypted.dmg
                
        else
                echo -e "\e[1;32mGood choice. Succession will now quit.\e[0m"
                exit
        fi
    fi
    # Clean up
    rm -rf /private/var/mobile/Media/Succession/ipsw/
    rm /private/var/mobile/Media/Succession/ipsw.ipsw
	if [[ needsDecryption = "true" ]];
then
		urlWithKey=`SuccessionCLIhelper --getKeyPageLink`
		if [[ urlWithKey != "Error"* ]]; then
			echo -e "\e[1;32mFetching decryption key...\e[0m"
			curl -L -# $urlWithKey -o /private/var/mobile/Media/Succession/keypage.txt -k
			decryptionKey=`SuccessionCLIhelper --getDecryptionKey`
			if [[ decryptionKey != "Error"* ]]; then
				echo -e "\e[1;32mDecrypting rootfilesystem...\e[0m"
				dmg extract /private/var/mobile/Media/Succession/encrypted.dmg /private/var/mobile/Media/Succession/rfs.dmg -k $decryptionKey
			else
				echo $decryptionKey
				exit 0
			fi
		else
			echo $urlWithKey
			exit 0
		fi
	else
		mv /private/var/mobile/Media/Succession/encrypted.dmg /private/var/mobile/Media/Succession/rfs.dmg
	fi
fi
echo -e "\e[1;32mRootfilesystem dmg successfully extracted!\e[0m" 
if grep -q "apfs" "/private/etc/fstab"; then
    echo -e "\e[1;32mDetected APFS filesystem!\e[0m"
    filesystemType="apfs"
elif grep -q "hfs" "/private/etc/fstab"; then
    echo -e "\e[1;32mDetected HFS+ filesystem!\e[0m"
    filesystemType="hfs"
else
    echo -e "\e[1;31mError! Unable to detect filesystem type.\e[0m"
    exit
fi
if [ -f /usr/bin/hdik ]; then
    hdikOutput=`hdik /private/var/mobile/Media/Succession/rfs.dmg`
    if [[ $hdikOutput == *"s2s1"* ]]; then
        for disk in $hdikOutput
        do
            if [[ $disk == *"s2s1" ]]; then
                attachedDiskPath=$disk
            fi
        done
    elif [[ $hdikOutput == *"s2"* ]]; then
        for disk in $hdikOutput
        do
            if [[ $disk == *"s2" ]]; then
                attachedDiskPath=$disk
            fi
        done
    else
        rm -r /private/var/mobile/Media/Succession/*
        echo -e "\e[1;31mError! IPSW download/extract was corrupted. Please rerun this script.\e[0m"
    fi
elif [ -f /usr/bin/attach ]; then
    attachOutput=`attach /private/var/mobile/Media/Succession/rfs.dmg`
    if [[ $attachOutput == *"s2s1"* ]]; then
        for disk in $attachOutput
        do
            if [[ $disk == *"s2s1" ]]; then
                attachedDiskPath=$disk
            fi
        done
    elif [[ $attachOutput == *"s2"* ]]; then
        for disk in $attachOutput
        do
            if [[ $disk == *"s2" ]]; then
                attachedDiskPath=$disk
            fi
        done
    else
        rm -r /private/var/mobile/Media/Succession/*
        echo -e "\e[1;31mError! IPSW download/extract was corrupted. Please rerun this script.\e[0m"
		exit 0
    fi
fi
mkdir -p /private/var/mnt/succ/
mount -t $filesystemType -o ro $attachedDiskPath /private/var/mnt/succ/
if grep -q "$ProductBuildVersion" "/var/mnt/succ/System/Library/CoreServices/SystemVersion.plist"; 
then
echo the root file system dmg has successfully been verified
fi   
#rm -r /private/var/mobile/Media/Succession/*
#SuccessionCLIhelper --beginRestore
exit 0