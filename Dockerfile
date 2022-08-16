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

RUN wget -P /tmp https://dl.google.com/go/go1.17.1.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf /tmp/go1.17.1.linux-amd64.tar.gz
RUN rm /tmp/go1.17.1.linux-amd64.tar.gz
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
RUN go get github.com/Jitendra7007/gdrive
RUN echo "KGdkcml2ZSB1cGxvYWQgIiQxIikgMj4gL2Rldi9udWxsIHwgZ3JlcCAtb1AgJyg/PD1VcGxvYWRlZC4pW2EtekEtWl8wLTktXSsnID4gZztnZHJpdmUgc2hhcmUgJChjYXQgZykgPi9kZXYvbnVsbCAyPiYxO2VjaG8gImh0dHBzOi8vZHJpdmUuZ29vZ2xlLmNvbS9maWxlL2QvJChjYXQgZykiCg==" | base64 -d > /usr/local/bin/gup && \
chmod +x /usr/local/bin/gup

RUN echo 'python3 jk/md.py -f "$1"' > /usr/local/bin/m && chmod +x /usr/local/bin/m
#rclone 
RUN curl https://rclone.org/install.sh | bash

#Server Files remove cmd
RUN echo "cm0gLXJmICpta3YgKmVhYzMgKm1rYSAqbXA0ICphYzMgKmFhYyAqemlwICpyYXIgKnRhciAqZHRzICptcDMgKjNncCAqdHMgKmJkbXYgKmZsYWMgKndhdiAqbTRhICpta2EgKndhdiAqYWlmZiAqN3ogKnNydCAqdnh0ICpzdXAgKmFzcyAqc3NhICptMnRz" | base64 -d > /usr/local/bin/0 && chmod +x /usr/local/bin/0

#Team drive me fast upload ke liye (up cmd)
RUN echo "cHl0aG9uMyAudXAvamt1cC5weSAtZiAiJDEi" | base64 -d > /usr/local/bin/up && chmod +x /usr/local/bin/up

#heroku files downloader - bot ki files ko https://.herokuapp.com ke through download karna
RUN echo "cGtpbGwgZ3VuaWNvcm4gMj4gdC50eHQ7cHl0aG9uMyAtbSBodHRwLnNlcnZlciAiJFBPUlQiIDI+IHQudHh0" | base64 -d > /usr/local/bin/h && chmod +x /usr/local/bin/h
RUN echo "ZWNobyAkQkFTRV9VUkxfT0ZfQk9ULyQocHl0aG9uMyAtYyAnZnJvbSB1cmxsaWIucGFyc2UgaW1wb3J0IHF1b3RlOyBpbXBvcnQgc3lzOyBwcmludChxdW90ZShzeXMuYXJndlsxXSkpJyAiJDEiKQ==" | base64 -d > /usr/local/bin/hl && chmod +x /usr/local/bin/hl

#local host downloader - bot ke storage
RUN echo "ZWNobyBodHRwOi8vbG9jYWxob3N0OjgwMDAvJChweXRob24zIC1jICdmcm9tIHVybGxpYi5wYXJzZSBpbXBvcnQgcXVvdGU7IGltcG9ydCBzeXM7IHByaW50KHF1b3RlKHN5cy5hcmd2WzFdKSknICIkMSIpCg==" | base64 -d > /usr/bin/g;chmod +x /usr/bin/g
#PSA unofficial telegram channel bypass script
RUN echo "aWYgWyAkMSBdCnRoZW4KcHl0aG9uMyAtYyAiZXhlYyhcImltcG9ydCByZXF1ZXN0cyBhcyBycSxz\neXNcbmZyb20gYmFzZTY0IGltcG9ydCBiNjRkZWNvZGUgYXMgZFxucz1ycS5nZXQoc3lzLmFyZ3Zb\nMV0pLnJlcXVlc3QudXJsLnNwbGl0KCc9JywxKVsxXVxuZm9yIGkgaW4gcmFuZ2UoMyk6IHM9ZChz\nKVxucHJpbnQoJ2h0dHAnK3MuZGVjb2RlKCkucnNwbGl0KCdodHRwJywxKVsxXSlcIikiICQxCmVs\nc2UKZWNobyAiYmFkIHJlcSIKZmkK" | base64 -d > /usr/bin/psa;chmod +x /usr/bin/psa

COPY . .
RUN pip3 install --no-cache-dir -r requirements.txt

CMD ["bash", "start.sh"]
