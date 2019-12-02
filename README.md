# Sparky Bonsai
![SCREENSHOT](https://github.com/maurosh/SparkyBonsai/raw/master/sparkybonsai_2019.jpg) 

Sparky Bonsai is a GNU/Linux distribution based on Debian/Sparkylinux in a portable form. Taking advantage of the experience of portable distros such as Slax, Porteus, Puppy and DebianDog, we made a remix of our favor Debian-based distro SparkyLinux.
The idea was to make a portable version of the linux distro having already installed at home, in cases we can’t, don’t need or wish to install it properly. 

We’ve test it in Stretch Debian version on troubleshooting and repairing other systems, booting diskless machines, checking used PCs for buying, hacking windows-locked office PCs, using machines with no traces and many more. We found it useful, we enjoyed it a lot and we decide to distribute the new Debian Buster based version.

Sparky Bonsai lives in a USB flash 4GB minimum and run with 512 MB of RAM on x86 processors. At the moment it’s only available in 64bit version. It fits on a DVD or CD optical disk and runs in ext2/3/4, fat32, xfs, exFAT file systems. In order to load it to RAM, 1GB is recommended.

It is a minimal Debian Buster file system using Debian linux kernel v. 4.19.0.6 with the BusterDog’s modules for porteus boot, live-boot-3x and aufs support. Kernel updates are not available the way they are on a properly installed linux system. As you may know, BusterDog uses the Antix Linux init system. Sparky Bonsai uses systemd as pure Debian and Sparky Linux. If you don’t wish to use systemd, check the BusterDog (based on Antix) or Beowolf (based on Devuan).

Sparky Bonsai use PCmanFM as file/desktop manager and JWM as windows manager. JWM’s menu construction is based on xdgmenumaker. It cames with Pale Moon as the default web browser, Mousepad as the default text editor and LXterminal as default terminal emulator. All DebianDog’s module and remaster scripts are included as well. 

Synaptic package manager is present and you can install all Debian and Sparkylinux packages. The BusterDog’s repository is inactive because of some Antix packets incompatible with Debian. You can use some packets if you’re sure they are compatible but DONT update your system with this repository enabled.

### Installation
Download the iso file from: https://osdn.net/dl/sparkybonsai/sparkybonsai-64-2019.iso

1. USB flash or removable Hard Disk Can be fat32 or ext2/3 formated. Ext4 filesystem is NOT recommended for installation on removable flash media.

1a.Extract iso files and copy /boot and /live folders at the root of your media OR burn iso on an optical disk (CD/DVD), boot it and copy those folders from /mnt/sr0 to the root of your removable media.

1b.Open a terminal and cd to (your disk path)/boot/syslinux

1c. Run the bash script bootinst.sh  as root (sudo) sh bootinst.sh
The Slax syslinux install script will make your media bootable ONLY for Sparky Bonsai. The script detects the location you run it, so run it ONLY into the directory of the removable media you wish to boot Sparky Bonsai.This will not format your disk, all other files will remain intact. 

1d. (Optional) Now you can manually edit the file /boot/syslinux/live.cfg and customize your boot options using the proper boot codes.

2. Alongside other Linux installation (grub boot).

2a.Extract iso files  and copy the /live folder OR burn iso on an optical disk (CD/DVD), boot it and copy /mnt/sr0/live folder at the root of your hard disk Can be formated in any linux compatible filesystem including ext4.

2b. Edit the file /etc/grub.d/40_custom as root and add a menu entry:
sudo nano /etc/grub.d/40_custom
add a menuentry with the codes you wish, ie:
menuentry "SparkyBonsai Porteus Boot" {
linux /live/vmlinuz1 from=/ changes=/live
initrd /live/initrd1.xz
}

2c. Update grub as root
sudo update-grub

2d.Reboot and find the custom option on grub’s menu.

3. Network boot (pxe) is also possible using the proper boot parameters in your server’s pxelinux.cfg/default. If you wish to save changes on server, the use of nfs server is recommended. Sparky Bonsai won’t run a pxe server pre-configured (as pure Porteus do), so you have to configure it according your server’s OS instructions.

### Usage

Sparky Bonsai is an ideal portable solution for “sparkers” (sparkylinux users) and Debian users. Some useful sparky tools as APTus are not included in order to keep the filesystem lightweight. You can install anytime APTus or any other sparky tool, but it’s recommended not to do this. You can always install sparky packets straight from Synaptic or apt. 
As mentioned before, some sparky tools such as the kernel related ones, are not useful in Sparky Bonsai. There’s no sense also to install a heavyweight desktop environment from sparky repos. If you wish to do so, consider of installing a full version of Sparkylinux on a hard disk or even on a removable media.

Sparky Bonsai will auto-mount all available disk partitions on boot, will use the first swap formated as swap and mount the rest under /mnt. Find the first partition of the first disk as /mnt/sda1, the first partition of the second disk as /mnt/sdb1, the first optical disk as /mnt/sr0 etc.

After a successful boot, logins automatically as user «puppy» getting tty (getty) and loads the desktop. So, if you prefere to login manually or auto-login another user, you have to manual edit the file /lib/systemd/system/getty@.service and change the line ExecStart=-/sbin/agetty --noclear -a puppy %I $TERM as below:

sudo nano /lib/systemd/system/getty@.service

find the line:
ExecStart=-/sbin/agetty --noclear -a puppy %I $TERM

and remove « -a puppy» for manual (or other method of) login or
change «puppy» to the existing user you wish to auto-login.

Note: There’s also a useful Porteus “cheatcode” login=username for auto-login. Unfortunately, it won’t work with Sparky Bonsai or other Debian-based distros using Porteus-boot. 

Puppy user is pre-configure to use sudo, open folders or edit files as root from PCmanFM, running synaptic and gparted without asking for password or running as root X-applications with «spsu» (sparky-su) and xsudo as replacements of the discontinued gksudo, for easy desktop use.

The main aim of Sparky Bonsai is the aufs support, where the filesystem contains compressed (squashfs files), non-compressed (changes directory), even encrypted (if you choose so) parts working together. There are available for download some compressed, squashfs files and you can always create your own files after installing the packets you choose.
Into /live directory there are the linux kernel (vmlinuz1) files for porteus-boot (initrd1.xz) or live-boot-3x (initrd.img) modes, buster 64 signature (buster-x86_64.sgn), the base filesystem (01-filesystem.squashfs) and the porteus structure directories. Find more about it at Porteus website: http://www.porteus.org/tutorials/26-general-info-tutorials/
Those directories, so-called “magic” folders, and contained files will be ignored with the boot code “nomagic”.

The /live/changes directory contains all new uncompressed files, installed packets, configuration flat files etc stored by the system during the session. It contains even deletion data it you choose to remove files from the base filesystem. Instead of /live/changes directory you can use a “frugal file”, a read/writeable image file created by the system on demand. It will ask you at the end of your session if you want to save your changes or ignore them. This file can be encrypted, only visible by the user who created it.

In order to mount your changes on next boot, you have to edit the boot parameter “changes=”. For example, the boot parameter “changes=/live” will load/save the filesystem part located at /live/changes directory. A parameter “changes=/somefolder” will load/save the /somefolder/changes files etc. The boot parameter “changes=/live/changes.dat” will load/save the contents in the frugal file “/live/changes.dat”.

Compressed filesystem modules with the extension “squashfs” will load alphabetically on startup. So, if you wish to load a squashfs module containing kernel modules, firmware etc and you want it loaded before the basic filesystem, you can rename it to something like “00-firmware.squashfs” which is alphabetically before “01-filesystem.squashfs”. Other modules containing apps running at the top of the basic system, can be  named  to something like “02-firefox.squashfs”, “03-firefox-addons.squashfs” etc.

Installing software packages its as easy as on Sparkylinux, Debian, Ubuntu etc. Just locate them in Synaptic package manager and install them normally. After a successful installation, you can save all your changes in a squashfs module via a DebianDog script
 in menu, under the “Module Tools” category, named “Create module from changes”, using the “mksquashfs” command. Choose the media (i.e. sda1), the temporary work-directory name (i.e. “works”) and the module name (i.e. “02-firefox.squashfs”). After copying all files in work directory, will ask for the compression method. Before choose your option, you can check the files in the /work directory, in the partition you choose before, edit them or change config files. After that click on your choice of compression (xz is recommended) and the script will proceed to squashfs creation. Now you can copy the new created file in the proper “magic folder” or in the root of /live directory to auto-load on next boot, or keep it in /live/optional directory to load it on demand. Note that after the “create module” procedure all your changes are stored in the squashfs module, so you can remove the contents of your /live/changes directory or .dat file, to prevent double-loading.
 
Note that JWM menu doesn’t auto-update after installations, so if you are expecting a menu icon from an installed application, you have to restart WM manually from the option under the Shutdown category of menu.
You can manually load a squashfs module anytime using the “SFS-Load GUI” under the “Modules Tools” category or right-click on a squashfs module in PCmanFM and choose “Activate module”. In case you’re expecting an icon in the menu, you have to manually restart WM as mentioned. Right-click on an activated squashfs module and choose “Deactivate module” to deactivate it and restart WM to hide the icon (if exists).

If you wish to execute any custom commands on startup, put them in /home/puppy/.startup file. They will be executed on desktop startup, after loading all squashfs modules. 

A suggested practice is to load in RAM the basic filesystem (using the boot code “copy2ram”) in porteus-boot mode, with a number of applications in squashfs modules into the /live/optional directory to activate/deactivate on demand and a /live/changes directory (using the boot code “changes=/live”) or .dat file (using the boot code “changes=/live/changes.dat”) to keep your configurations and documents. 

Hope to enjoy this floral pup as we did. If you do, consider sending a donation to our favor Debian distribution, Sparkylinux. https://sparkylinux.org/donate/

Links: 
Debian GNU/Linux https://www.debian.org/
Sparkylinux: https://sparkylinux.org/	forum: https://forum.sparkylinux.org/
DebianDog: https://debiandog.github.io/doglinux/
BusterDog forum thread: http://murga-linux.com/puppy/viewtopic.php?t=117255
Porteus Linux: http://www.porteus.org/	forum: https://forum.porteus.org/
Slax Linux: https://www.slax.org/
Puppy Linux: http://puppylinux.com/	forum: http://www.murga-linux.com/puppy/

Downloads:
SparkyBonsai 64bit, December 2019: https://osdn.net/dl/sparkybonsai/sparkybonsai-64-2019.iso

Modules:
Firefox ESR:	https://osdn.net/dl/sparkybonsai/02-firefox.squashfs
Thunderbird + Lightning addon	https://osdn.net/dl/sparkybonsai/02-thunderbird.squashfs
LibreOffice:	https://osdn.net/dl/sparkybonsai/02-libreoffice.squashfs
Sparky-play +Sparky-player (simple mp3 and video players):	https://osdn.net/dl/sparkybonsai/02-mediaplay.squashfs
