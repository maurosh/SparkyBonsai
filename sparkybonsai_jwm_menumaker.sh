#!/bin/bash
## SparkyBonsai JWM Menu Maker bash script 
## published under GNU GPLv2
## author mauros 
## for SparkyBonsai GNU/Linux https://github.com/maurosh/SparkyBonsai
## Usage: save and chmod +x or register this script on your system and put into .jwmrc file
## the xml tag: "<include>exec:sh /path/to/sparkybonsai_jwm_menumaker.sh</include>"

## Creating array
IFS=$'\n';
apparray=($(find /usr/share/applications/ -maxdepth 1 -name "*.desktop"));

## Fixing array
for i in "${!apparray[@]}"; do
NoDisplay=$(grep '^NoDisplay' ${apparray[$i]} | sed 's/^NoDisplay=//')
Terminal=$(grep '^Terminal' ${apparray[$i]} | sed 's/^Terminal=//')
   if [[ "$NoDisplay" = "true" || "$Terminal" = "true" ]]; then
      unset -v 'apparray[$i]';
   fi
done
IFS=$'\n' appsorted=($(sort <<<"${apparray[*]}"))

apparray=("${appsorted[@]}");
unset appsorted;

## Reading files
catarray=();
namarray=();
icoarray=();
exearray=();
for i in "${!apparray[@]}"; do
      Categories=$(grep '^Categories' ${apparray[$i]} | sed 's/^Categories=//');
      Name=$(grep '^Name=' ${apparray[$i]} | sed 's/^Name=//' | tail -1)
      Icon=$(grep '^Icon=' ${apparray[$i]} | sed 's/^Icon=//')
      Exec=$(grep '^Exec' ${apparray[$i]} | sed 's/^Exec=//' | tail -1 | sed 's/%.//')
      catarray+=( "$Categories" );
      namarray+=( "$Name" );
      icoarray+=( "$Icon" );
      exearray+=( "$Exec" );
done

## Categories
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"Utility"* && "$Categories" != *"System"* && "$Categories" != *"Modul"* ]]; then
         cacc="yes";
      fi
      if [[ "$Categories" == *"Education"* ]]; then
         cedu="yes";
      fi
      if [[ "$Categories" == *"Game"* ]]; then
         cgam="yes";
      fi
      if [[ "$Categories" == *"Graphics"* ]]; then
         cgra="yes";
      fi
      if [[ "$Categories" == *"Network"* ]]; then
         cnet="yes";
      fi
      if [[ "$Categories" == *"Office"* ]]; then
         coff="yes";
      fi
      if [[ "$Categories" == *"Other"* ]]; then
         coth="yes";
      fi
      if [[ "$Categories" == *"Development"* ]]; then
         cdev="yes";
      fi
      if [[ "$Categories" == *"Audio"* || "$Categories" == *"Video"* || "$Categories" == *"Player"* ]]; then
         caud="yes";
      fi
      if [[ "$Categories" == *"System"* || "$Categories" == *"Settings"* && "$Categories" != *"Modul"* ]]; then
         csys="yes";
      fi
      if [[ "$Categories" == *"Modul"* ]]; then
         cmod="yes";
      fi
done

## XML header
echo '<?xml version="1.0"?>';
echo '<JWM>';

## Accessories Menu
if [[ "$cacc" = "yes" ]]; then
echo '<Menu label="Accessories" icon="applications-accessories.svg">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"Utility"* && "$Categories" != *"System"* && "$Categories" != *"Modul"* ]]; then
         Name=${namarray[$i]};
         Icon=${icoarray[$i]};
         Exec=${exearray[$i]};
         echo '<Program label="'$Name'" icon="'$Icon'">'$Exec'</Program>'; 
      fi
done
echo '</Menu>';
fi

## Education Menu
if [[ "$cedu" = "yes" ]]; then
echo '<Menu label="Education" icon="applications-science.svg">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"Education"* ]]; then
         Name=${namarray[$i]};
         Icon=${icoarray[$i]};
         Exec=${exearray[$i]};
         echo '<Program label="'$Name'" icon="'$Icon'">'$Exec'</Program>'; 
      fi
done
echo '</Menu>';
fi

## Games Menu
if [[ "$cgam" = "yes" ]]; then
echo '<Menu label="Games" icon="applications-games.svg">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"Game"* ]]; then
         Name=${namarray[$i]};
         Icon=${icoarray[$i]};
         Exec=${exearray[$i]};
         echo '<Program label="'$Name'" icon="'$Icon'">'$Exec'</Program>'; 
      fi
done
echo '</Menu>';
fi

## Graphics Menu
if [[ "$cgra" = "yes" ]]; then
echo '<Menu label="Graphics" icon="applications-graphics.svg">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"Graphics"* ]]; then
         Name=${namarray[$i]};
         Icon=${icoarray[$i]};
         Exec=${exearray[$i]};
         echo '<Program label="'$Name'" icon="'$Icon'">'$Exec'</Program>'; 
      fi
done
echo '</Menu>';
fi

## Network Menu
if [[ "$cnet" = "yes" ]]; then
echo '<Menu label="Network" icon="applications-internet.svg">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"Network"* ]]; then
         Name=${namarray[$i]};
         Icon=${icoarray[$i]};
         Exec=${exearray[$i]};
         echo '<Program label="'$Name'" icon="'$Icon'">'$Exec'</Program>'; 
      fi
done
echo '</Menu>';
fi

## Office Menu
if [[ "$coff" = "yes" ]]; then
echo '<Menu label="Office" icon="applications-office.svg">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"ffice"* ]]; then
         Name=${namarray[$i]};
         Icon=${icoarray[$i]};
         Exec=${exearray[$i]};
         echo '<Program label="'$Name'" icon="'$Icon'">'$Exec'</Program>'; 
      fi
done
echo '</Menu>';
fi

## Other Menu
if [[ "$coth" = "yes" ]]; then
echo '<Menu label="Other" icon="applications-other.svg">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"Other"* ]]; then
         Name=${namarray[$i]};
         Icon=${icoarray[$i]};
         Exec=${exearray[$i]};
         echo '<Program label="'$Name'" icon="'$Icon'">'$Exec'</Program>'; 
      fi
done
echo '</Menu>';
fi

## Development Menu
if [[ "$cdev" = "yes" ]]; then
echo '<Menu label="Development" icon="applications-development.svg">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"Development"* ]]; then
         Name=${namarray[$i]};
         Icon=${icoarray[$i]};
         Exec=${exearray[$i]};
         echo '<Program label="'$Name'" icon="'$Icon'">'$Exec'</Program>'; 
      fi
done
echo '</Menu>';
fi

## AudioVideo Menu
if [[ "$caud" = "yes" ]]; then
echo '<Menu label="AudioVideo" icon="applications-multimedia.svg">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"Audio"* || "$Categories" == *"Video"* || "$Categories" == *"Player"* ]]; then
         Name=${namarray[$i]};
         Icon=${icoarray[$i]};
         Exec=${exearray[$i]};
         echo '<Program label="'$Name'" icon="'$Icon'">'$Exec'</Program>'; 
      fi
done
echo '</Menu>';
fi

## System Menu
if [[ "$csys" = "yes" ]]; then
echo '<Menu label="System" icon="preferences-system.svg">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"System"* && "$Categories" != *"Modul"* ]]; then
         Name=${namarray[$i]};
         Icon=${icoarray[$i]};
         Exec=${exearray[$i]};
         echo '<Program label="'$Name'" icon="'$Icon'">'$Exec'</Program>'; 
      fi
done
echo '</Menu>';
fi
## /System Menu

## Modules Menu
if [[ "$cmod" = "yes" ]]; then
echo '<Menu label="Module Tools" icon="gnome-settings.svg">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"Modul"* ]]; then
         Name=${namarray[$i]};
         Icon=${icoarray[$i]};
         Exec=${exearray[$i]};
         echo '<Program label="'$Name'" icon="'$Icon'">'$Exec'</Program>'; 
      fi
done
echo '</Menu>';
fi
## XML footer
unset apparray;
unset catarray;
unset namarray;
unset icoarray;
unset exearray;
unset IFS;
echo '</JWM>';
