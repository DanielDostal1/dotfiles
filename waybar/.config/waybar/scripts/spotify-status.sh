#!/bin/sh

status=$(playerctl status 2>/dev/null)
metadata=$(playerctl metadata --format '{{artist}} - {{title}}' 2>/dev/null)
cache_file="/tmp/waybar-spotify-fun-message"

fun_messages=(
    "The DJ fell asleep - wake them up!"
    "No jams detected, try humming?"
    "Silence is golden... but music is better!"
    "The dance floor is empty!"
    "Spotify’s on a coffee break "  
    "No tunes? Time for a sing-along!"
    "The beat took a vacation!"
    "All quiet - perfect time for air guitar!"
    "No music - maybe try whistling?"
    "The playlist ghosted us!"
)

if [ "$status" = "Playing" ]; then
    icon=""
    [ -f "$cache_file" ] && rm -f "$cache_file"
elif [ "$status" = "Paused" ]; then
    icon=""
    [ -f "$cache_file" ] && rm -f "$cache_file"
else
    icon=""
    if [ -f "$cache_file" ]; then
        metadata=$(cat "$cache_file")
    else
        message="${fun_messages[$RANDOM % ${#fun_messages[@]}]}"
        metadata="$message"
        echo "$message" > "$cache_file"
    fi
fi

echo "$icon $metadata"
