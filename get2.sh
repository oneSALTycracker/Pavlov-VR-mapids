#!/bin/bash
# SET THIS TO WHERE SCRIPT IS 
dir="/home/steam/code2/modio"

# WHERE IS THE FINISHED LIST GOING
filename=$( echo $(date +%m-%d-%y- )rankedPavlov.tsv )

#SET GLOBAL 
export filename

#SET PASSWORDS 
source "${dir}/.vault"


cd $(echo $dir)

curl -X GET "${APIKEY0}/v1/games/3959/mods?api_key=${APIKEY1}&_offset=0"   -H 'Accept: application/json' > "${dir}/bin/api0.dump"
sleep 5s
curl -X GET "${APIKEY0}/v1/games/3959/mods?api_key=${APIKEY1}&_offset=0"  -H 'Accept: application/json' > "${dir}/bin/api1.dump"
sleep 5s
curl -X GET "${APIKEY0}/v1/games/3959/mods?api_key=${APIKEY1}&_offset=0"  -H 'Accept: application/json' > "${dir}/bin/api2.dump"
sleep 5s
curl -X GET "${APIKEY0}/v1/games/3959/mods?api_key=${APIKEY1}&_offset=0"  -H 'Accept: application/json' > "${dir}/bin/api3.dump"
sleep 5s
curl -X  GET "${APIKEY0}/v1/games/3959/mods?api_key=${APIKEY1}&_offset=0"  -H 'Accept: application/json' > "${dir}/bin/api4.dump"
sleep 5s


cat "${dir}/bin/api0.dump" | jq -j ' .data[]| .stats.popularity_rank_position, "$UGC", .id,"$", .name,"$", .profile_url,"$", .submitted_by.username," ", .submitted_by.profile_url," ", .submitted_by.avatar.original, " DOWNLOADS TODAY; ", .stats.downloads_today," TOTAL; ", .stats.downloads_total," RANK; ", "\n"  ' > "${dir}/bin/PAVLOV-mapsRAW.txt"

cat "${dir}/bin/api1.dump" | jq -j ' .data[]| .stats.popularity_rank_position, "$UGC", .id,"$", .name,"$", .profile_url,"$", .submitted_by.username," ", .submitted_by.profile_url," ", .submitted_by.avatar.original, " DOWNLOADS TODAY; ", .stats.downloads_today," TOTAL; ", .stats.downloads_total," RANK; ", "\n"  ' >> "${dir}/bin/PAVLOV-mapsRAW.txt"

cat "${dir}/bin/api2.dump" | jq -j ' .data[]| .stats.popularity_rank_position, "$UGC", .id,"$", .name,"$", .profile_url,"$", .submitted_by.username," ", .submitted_by.profile_url," ", .submitted_by.avatar.original, " DOWNLOADS TODAY; ", .stats.downloads_today," TOTAL; ", .stats.downloads_total," RANK; ", "\n"  ' >> "${dir}/bin/PAVLOV-mapsRAW.txt"

cat "${dir}/bin/api3.dump" | jq -j ' .data[]| .stats.popularity_rank_position, "$UGC", .id,"$", .name,"$", .profile_url,"$", .submitted_by.username," ", .submitted_by.profile_url," ", .submitted_by.avatar.original, " DOWNLOADS TODAY; ", .stats.downloads_today," TOTAL; ", .stats.downloads_total," RANK; ", "\n"  ' >> "${dir}/bin/PAVLOV-mapsRAW.txt"t

cat "${dir}/bin/api4.dump" | jq -j ' .data[]| .stats.popularity_rank_position, "$UGC", .id,"$", .name,"$", .profile_url,"$", .submitted_by.username," ", .submitted_by.profile_url," ", .submitted_by.avatar.original, " DOWNLOADS TODAY; ", .stats.downloads_today," TOTAL; ", .stats.downloads_total," RANK; ", "\n"  ' >> "${dir}/bin/PAVLOV-mapsRAW.txt"


echo "UGC,NAME,URL" > "${dir}/rankedPavlov.csv"
cat "${dir}/PAVLOV-mapsRAW.txt" | tr -d "|"  | sort -n  | awk -F"$" '{print $2","$3","$4}' >> "${dir}/rankedPavlov.csv"

cat "${dir}/rankedPavlov.csv" | tr -d "|"  |  column -s "\," -t > table-rankedPavlov.txt



#bash "${dir}/discord.sh" \
#  --webhook-url="${HOOK}" \
#  --file "${dir}/rankedPavlov.csv" \
#  --text "todays pavlov maps by most downloads in the day \\n list rebuilt every hour "



git commit -am "SEND IT" ; git push