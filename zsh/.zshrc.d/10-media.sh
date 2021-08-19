#!/usr/bin/env zsh
# shellcheck shell=bash

# Downloads audio from a youtube video
function youtube-audio {
    youtube-dl --extract-audio --audio-format flac --prefer-ffmpeg "$1"
}

function youtube-video {
    youtube-dl --format='bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best' --extract-video --prefer-ffmpeg "$1"
}

# Extracts audio from a video
function video-audio-extract {
    ffmpeg -i "$1" -vn -acodec libvorbis "$1-audio.ogg"
}

# Removes audio from a video
function video-audio-strip {
    ffmpeg -i "$1" -c copy -an "$1-nosound.${1#*.}"
}

# Takes whatever video format and optimizes it
# for size and compatibility
function video-normalize {
    local inputfile="$1"
    local outputfile="${inputfile%.*}.mp4"
    ffmpeg -i "$inputfile" -c:v libx264 -preset veryfast "$outputfile"
    echo "Wrote: $outputfile"
    ls -lah "$inputfile"
    ls -lah "$outputfile"
}

function image-normalize {
    for filename; do
        (
            local output
            output="$(file_name "$filename").jpg"
            echo "$filename -> $output"
            magick convert "$filename" "$output"
            magick mogrify -resize 1000x1000 "$output"
        ) &
    done
    wait
}

function ocr {
    convert "$1" -resize 400% -type Grayscale - | tesseract - -
}

is_installed zbarimg && alias qr-decode="zbarimg"
