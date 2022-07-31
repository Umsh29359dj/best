FROM 412314/mltb:heroku

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

RUN apt-get -y update && \
    apt-get install -y wget 

RUN apt -qq install -y --no-install-recommends mediainfo
RUN wget -q -O - https://mkvtoolnix.download/gpg-pub-moritzbunkus.txt | apt-key add - && \
    wget -qO - https://ftp-master.debian.org/keys/archive-key-10.asc | apt-key add -
RUN sh -c 'echo "deb https://mkvtoolnix.download/debian/ buster main" >> /etc/apt/sources.list.d/bunkus.org.list' && \
    sh -c 'echo deb http://deb.debian.org/debian buster main contrib non-free | tee -a /etc/apt/sources.list' && apt update && apt install -y mkvtoolnix

#rclone 
RUN curl https://rclone.org/install.sh | bash

RUN wget -P /tmp https://dl.google.com/go/go1.17.1.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf /tmp/go1.17.1.linux-amd64.tar.gz
RUN rm /tmp/go1.17.1.linux-amd64.tar.gz
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
RUN go get github.com/Jitendra7007/gdrive

#team drive downloader
RUN curl -L https://github.com/jaskaranSM/drivedlgo/releases/download/1.5/drivedlgo_1.5_Linux_x86_64.gz -o drivedl.gz && \
    7z x drivedl.gz && mv drivedlgo /usr/bin/drivedl && chmod +x /usr/bin/drivedl && rm drivedl.gz
RUN echo 'python3 uptobox.pyc "$1"' > /usr/local/bin/utb && chmod +x /usr/local/bin/utb


#PSA unofficial telegram channel bypass script
RUN echo "aWYgWyAkMSBdCnRoZW4KcHl0aG9uMyAtYyAiZXhlYyhcImltcG9ydCByZXF1ZXN0cyBhcyBycSxz\neXNcbmZyb20gYmFzZTY0IGltcG9ydCBiNjRkZWNvZGUgYXMgZFxucz1ycS5nZXQoc3lzLmFyZ3Zb\nMV0pLnJlcXVlc3QudXJsLnNwbGl0KCc9JywxKVsxXVxuZm9yIGkgaW4gcmFuZ2UoMyk6IHM9ZChz\nKVxucHJpbnQoJ2h0dHAnK3MuZGVjb2RlKCkucnNwbGl0KCdodHRwJywxKVsxXSlcIikiICQxCmVs\nc2UKZWNobyAiYmFkIHJlcSIKZmkK" | base64 -d > /usr/bin/psa;chmod +x /usr/bin/psa

#Server Files remove cmd
RUN echo "cm0gLXJmICpta3YgKmVhYzMgKm1rYSAqbXA0ICphYzMgKmFhYyAqemlwICpyYXIgKnRhciAqZHRzICptcDMgKjNncCAqdHMgKmJkbXYgKmZsYWMgKndhdiAqbTRhICpta2EgKndhdiAqYWlmZiAqN3ogKnNydCAqdnh0ICpzdXAgKmFzcyAqc3NhICptMnRz" | base64 -d > /usr/local/bin/0 && chmod +x /usr/local/bin/0
RUN wget -P /usr/local/bin/ https://raw.githubusercontent.com/Jitendra7007/testbot/main/gup && chmod +x /usr/local/bin/gup && \
    wget -P /usr/local/bin/ https://raw.githubusercontent.com/Jitendra7007/testbot/main/l && chmod +x /usr/local/bin/l && \
    wget -P /usr/local/bin/ https://raw.githubusercontent.com/Jitendra7007/testbot/main/g && chmod +x /usr/local/bin/g && \
    wget -P /usr/local/bin/ https://raw.githubusercontent.com/Jitendra7007/testbot/main/0 && chmod +x /usr/local/bin/0 && \
    wget -P /usr/local/bin/ https://raw.githubusercontent.com/Jitendra7007/testbot/main/h && chmod +x /usr/local/bin/h && \
    wget -P /usr/local/bin/ https://raw.githubusercontent.com/Jitendra7007/testbot/main/hl && chmod +x /usr/local/bin/hl && \
    wget -P /usr/local/bin/ https://raw.githubusercontent.com/Jitendra7007/testbot/main/up && chmod +x /usr/local/bin/up
    


COPY . .
RUN pip3 install --no-cache-dir -r requirements.txt

CMD ["bash", "start.sh"]
