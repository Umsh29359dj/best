#config and run
mkdir .gdrive && wget -P /usr/src/app/.gdrive/ https://raw.githubusercontent.com/bowchaw/mkoin/bond2/.gdrive/token_v2.json
gdrive download -r 1f3c9WU6zDFzK5GQMWuW_sbl-fOiFbsZC > /dev/null
python3 update.py && python3 -m bot
