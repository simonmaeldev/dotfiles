#!/bin/bash

# Function to show usage
show_usage() {
    echo "Usage: compress-video [--type FORMAT] INPUT_FILE TARGET_SIZE_MB"
    echo "Example: compress-video --type mp4 input.mov 25"
    echo "         compress-video input.mov 25"
    exit 1
}

# Parse arguments
OUTPUT_FORMAT=""
while [[ $# -gt 0 ]]; do
    case $1 in
        --type)
            OUTPUT_FORMAT="$2"
            shift 2
            ;;
        -*)
            echo "Unknown option $1"
            show_usage
            ;;
        *)
            break
            ;;
    esac
done

# Check if we have the required arguments
if [ $# -ne 2 ]; then
    show_usage
fi

INPUT_FILE="$1"
TARGET_SIZE_MB="$2"

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' does not exist."
    exit 1
fi

# Check if ffmpeg and ffprobe are available
if ! command -v ffmpeg &> /dev/null || ! command -v ffprobe &> /dev/null; then
    echo "Error: ffmpeg and ffprobe are required but not installed."
    exit 1
fi

# Get file extension and base name
BASENAME=$(basename "$INPUT_FILE" | sed 's/\.[^.]*$//')
EXTENSION="${INPUT_FILE##*.}"

# Determine output format and extension
if [ -n "$OUTPUT_FORMAT" ]; then
    OUTPUT_EXT="$OUTPUT_FORMAT"
else
    OUTPUT_EXT="$EXTENSION"
fi

OUTPUT_FILE="${BASENAME}_compressed.${OUTPUT_EXT}"

# Get video duration in seconds
echo "Analyzing video..."
DURATION=$(ffprobe -v quiet -show_entries format=duration -of csv=p=0 "$INPUT_FILE")

if [ -z "$DURATION" ] || [ "$(echo "$DURATION == 0" | bc -l 2>/dev/null || echo "1")" = "1" ]; then
    echo "Error: Could not determine video duration."
    exit 1
fi

# Calculate target bitrate (with safety margin)
# Target size in bits, minus audio bitrate estimate (128kbps), with 10% safety margin
TARGET_SIZE_BITS=$(echo "$TARGET_SIZE_MB * 8 * 1024 * 1024" | bc)
AUDIO_BITRATE_BITS=$(echo "128 * 1024" | bc)  # 128 kbps for audio
SAFETY_FACTOR="0.9"  # 10% safety margin to ensure we stay under target

VIDEO_BITRATE_BITS=$(echo "($TARGET_SIZE_BITS - $AUDIO_BITRATE_BITS * $DURATION) * $SAFETY_FACTOR / $DURATION" | bc)
VIDEO_BITRATE_KBPS=$(echo "$VIDEO_BITRATE_BITS / 1024" | bc)

# Ensure minimum bitrate
MIN_BITRATE=100
if [ "$(echo "$VIDEO_BITRATE_KBPS < $MIN_BITRATE" | bc)" = "1" ]; then
    echo "Warning: Calculated bitrate ($VIDEO_BITRATE_KBPS kbps) is very low."
    echo "Setting minimum bitrate to $MIN_BITRATE kbps."
    VIDEO_BITRATE_KBPS=$MIN_BITRATE
fi

echo "Input file: $INPUT_FILE"
echo "Duration: $(printf "%.2f" "$DURATION") seconds"
echo "Target size: ${TARGET_SIZE_MB}MB"
echo "Calculated video bitrate: ${VIDEO_BITRATE_KBPS}k"
echo "Output file: $OUTPUT_FILE"

# Two-pass encoding for better quality
echo ""
echo "Starting compression (2-pass encoding)..."

# First pass
echo "Pass 1/2..."
ffmpeg -y -i "$INPUT_FILE" -c:v libx264 -b:v "${VIDEO_BITRATE_KBPS}k" -pass 1 -an -f null /dev/null -v quiet

if [ $? -ne 0 ]; then
    echo "Error: First pass failed."
    rm -f ffmpeg2pass-0.log
    exit 1
fi

# Second pass
echo "Pass 2/2..."
ffmpeg -y -i "$INPUT_FILE" -c:v libx264 -b:v "${VIDEO_BITRATE_KBPS}k" -pass 2 -c:a aac -b:a 128k "$OUTPUT_FILE" -v quiet

if [ $? -ne 0 ]; then
    echo "Error: Second pass failed."
    rm -f ffmpeg2pass-0.log
    exit 1
fi

# Clean up pass files
rm -f ffmpeg2pass-0.log

# Check output file size
if [ -f "$OUTPUT_FILE" ]; then
    OUTPUT_SIZE_BYTES=$(stat -c%s "$OUTPUT_FILE" 2>/dev/null || stat -f%z "$OUTPUT_FILE" 2>/dev/null)
    OUTPUT_SIZE_MB=$(echo "scale=2; $OUTPUT_SIZE_BYTES / 1024 / 1024" | bc)
    
    echo ""
    echo "Compression completed!"
    echo "Output file: $OUTPUT_FILE"
    echo "Final size: ${OUTPUT_SIZE_MB}MB (target: ${TARGET_SIZE_MB}MB)"
    
    # Check if we exceeded target (shouldn't happen with safety margin)
    if [ "$(echo "$OUTPUT_SIZE_MB > $TARGET_SIZE_MB" | bc)" = "1" ]; then
        echo "Warning: Output size exceeds target. You may need to run again with a smaller target."
    fi
else
    echo "Error: Output file was not created."
    exit 1
fi