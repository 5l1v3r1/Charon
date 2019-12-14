# Charon

Docker container for decoding TrendMicro quarantine files. Decode the quarantined file, zip it up, and pull it back to an analysis machine, or use this container to perform light analysis.

## QuickStart  

Build locally.

```bash
docker build -t charon .
```

## Usage

```bash
# Run charon
docker run -it charon

# Get container id.
docker ps

# Copy .qtn file to VSEncode directory.
docker cp <.qtn file path> <container id>:/opt/VSEncode/<.qtn file name>

# Navigate to VSEncode directory.
cd /opt/VSEncode

# Decode the .qtn file.
wine VSEncode.exe -d -i decrypt_location.txt -debug
```

## Tools

* TrendMicro QTN Decode via Wine using VSEncode.exe
* HybridAnalysis VxAPI
* Radare2
* PowerShell
* Unzip
* Python3
* ExifTool
* Oletools
* Binwalk