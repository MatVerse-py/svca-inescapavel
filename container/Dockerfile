FROM debian@sha256:2a0c9e1b8f0d7a4f0f9c8c9a6c8a6e4c2f5b6d7a9e0b1c2d3e4f5a6b7c8d9e0

ENV LC_ALL=C
ENV TZ=UTC

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates curl git brotli minisign build-essential golang-go \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN chmod +x build.sh verify.sh

CMD ["./build.sh"]
