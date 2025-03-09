#!/bin/bash

# Check if a URL is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <video_or_playlist_url>"
    exit 1
fi

# Get the URL
url="$1"

# Use yt-dlp to fetch information about the URL
info=$(yt-dlp --flat-playlist --dump-single-json "$url" 2>/dev/null)

# Check if the URL is a playlist or a single video
if echo "$info" | grep -q '"entries"'; then
    # URL is a playlist
    echo "Detected playlist. Downloading entire playlist..."
    yt-dlp -x --audio-format mp3 -o "%(playlist_title)s/%(playlist_index)d %(title)s.%(ext)s" "$url"
else
    # URL is a single video
    echo "Detected single video. Downloading single video..."
    yt-dlp -x --audio-format mp3 -o "%(title)s.%(ext)s" "$url"
fi
