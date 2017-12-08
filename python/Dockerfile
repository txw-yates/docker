FROM alpine:3.6


RUN apk update && \
	apk add python3 && \
	apk add --virtual=build-dependencies wget ca-certificates && \
	wget "https://bootstrap.pypa.io/get-pip.py" -O /dev/stdout --no-check-certificate | python3 && \
	apk del build-dependencies && \
	rm -rf /var/cache/apk/*
