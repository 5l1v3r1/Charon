# Charon

Docker container for decoding TrendMicro quarantine files.

## Tools

* TrendMicro QTN Decode via Wine using VSEncode.exe
* HybridAnalysis VxAPI
* Radare2
* PowerShell
* Unzip
* Python3
* ExifTool

## Decode TrendMicro Quarantine File

```bash
# Copy .qtn file to VSEncode directory.
docker cp <.qtn file path> /root/VSEncode/<.qtn file name>
# Navigate to VSEncode directory.
cd /root/VSEncode
# Decode the .qtn file.
wine VSEncode.exe -d -i decrypt_location.txt -debug
```
