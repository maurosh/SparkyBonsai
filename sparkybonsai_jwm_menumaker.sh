#!/bin/bash
## SparkyBonsai JWM Menu Maker bash script 
## published under GNU GPLv2
## author mauros 
## for SparkyBonsai GNU/Linux https://github.com/maurosh/SparkyBonsai
## Usage: save and chmod +x or register this script on your system and put into .jwmrc file
## the xml tag: "<include>exec:sh /path/to/sparkybonsai_jwm_menumaker.sh</include>"

## Categories icons
# accessories
icoacc="applications-accessories.svg";
# education
icoedu="applications-science.svg";
# games
icogam="applications-games.svg";
# graphics
icogra="applications-graphics.svg";
# network
iconet="applications-internet.svg";
# office
icooff="applications-office.svg";
# other
icooth="applications-other.svg";
# development
icodev="applications-development.svg";
# audiovideo
icoaud="applications-multimedia.svg";
# system
icosys="preferences-system.svg";
# modules
icomod="gnome-settings.svg";

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
      catarray+=( "$(grep '^Categories' ${apparray[$i]} | sed 's/^Categories=//')" );
      namarray+=( "$(grep '^Name=' ${apparray[$i]} | sed 's/^Name=//' | tail -1)" );
      icoarray+=( "$(grep '^Icon=' ${apparray[$i]} | sed 's/^Icon=//')" );
      exearray+=( "$(grep '^Exec' ${apparray[$i]} | sed 's/^Exec=//' | tail -1 | sed 's/%.//')" );
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
echo '<Menu label="Accessories" icon="'$icoacc'">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"Utility"* && "$Categories" != *"System"* && "$Categories" != *"Modul"* ]]; then
         echo '<Program label="'${namarray[$i]}'" icon="'${icoarray[$i]}'">'${exearray[$i]}'</Program>'; 
      fi
done
echo '</Menu>';
fi

## Education Menu
if [[ "$cedu" = "yes" ]]; then
echo '<Menu label="Education" icon="'$icoedu'">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"Education"* ]]; then
         echo '<Program label="'${namarray[$i]}'" icon="'${icoarray[$i]}'">'${exearray[$i]}'</Program>'; 
      fi
done
echo '</Menu>';
fi

## Games Menu
if [[ "$cgam" = "yes" ]]; then
echo '<Menu label="Games" icon="'$icogam'">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"Game"* ]]; then
         echo '<Program label="'${namarray[$i]}'" icon="'${icoarray[$i]}'">'${exearray[$i]}'</Program>'; 
      fi
done
echo '</Menu>';
fi

## Graphics Menu
if [[ "$cgra" = "yes" ]]; then
echo '<Menu label="Graphics" icon="'$icogra'">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"Graphics"* ]]; then
         echo '<Program label="'${namarray[$i]}'" icon="'${icoarray[$i]}'">'${exearray[$i]}'</Program>'; 
      fi
done
echo '</Menu>';
fi

## Network Menu
if [[ "$cnet" = "yes" ]]; then
echo '<Menu label="Network" icon="'$iconet'">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"Network"* ]]; then
         echo '<Program label="'${namarray[$i]}'" icon="'${icoarray[$i]}'">'${exearray[$i]}'</Program>'; 
      fi
done
echo '</Menu>';
fi

## Office Menu
if [[ "$coff" = "yes" ]]; then
echo '<Menu label="Office" icon="'$icooff'">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"ffice"* ]]; then
         echo '<Program label="'${namarray[$i]}'" icon="'${icoarray[$i]}'">'${exearray[$i]}'</Program>'; 
      fi
done
echo '</Menu>';
fi

## Other Menu
if [[ "$coth" = "yes" ]]; then
echo '<Menu label="Other" icon="'$icooth'">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"Other"* ]]; then
         echo '<Program label="'${namarray[$i]}'" icon="'${icoarray[$i]}'">'${exearray[$i]}'</Program>'; 
      fi
done
echo '</Menu>';
fi

## Development Menu
if [[ "$cdev" = "yes" ]]; then
echo '<Menu label="Development" icon="'$icodev'">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"Development"* ]]; then
         echo '<Program label="'${namarray[$i]}'" icon="'${icoarray[$i]}'">'${exearray[$i]}'</Program>'; 
      fi
done
echo '</Menu>';
fi

## AudioVideo Menu
if [[ "$caud" = "yes" ]]; then
echo '<Menu label="AudioVideo" icon="'$icoaud'">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"Audio"* || "$Categories" == *"Video"* || "$Categories" == *"Player"* ]]; then
         echo '<Program label="'${namarray[$i]}'" icon="'${icoarray[$i]}'">'${exearray[$i]}'</Program>'; 
      fi
done
echo '</Menu>';
fi

## System Menu
if [[ "$csys" = "yes" ]]; then
echo '<Menu label="System" icon="'$icosys'">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"System"* && "$Categories" != *"Modul"* ]]; then
         echo '<Program label="'${namarray[$i]}'" icon="'${icoarray[$i]}'">'${exearray[$i]}'</Program>'; 
      fi
done
echo '</Menu>';
fi

## Modules Menu
if [[ "$cmod" = "yes" ]]; then
echo '<Menu label="Module Tools" icon="'$icomod'">';
for i in "${!apparray[@]}"; do
      Categories=${catarray[$i]};
      if [[ "$Categories" == *"Modul"* ]]; then
         echo '<Program label="'${namarray[$i]}'" icon="'${icoarray[$i]}'">'${exearray[$i]}'</Program>'; 
      fi
done
echo '</Menu>';
fi
## cleaning
unset apparray;
unset catarray;
unset namarray;
unset icoarray;
unset exearray;
unset IFS;

## XML footer
echo '</JWM>';
