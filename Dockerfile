FROM alpine:3.21 AS base

RUN apk update && apk upgrade -al --prune && apk add \
	git \
	build-base \
	python3 \
	linux-headers \
	py3-yaml

FROM base AS builder

RUN apk add \
	curl-dev \
	libarchive-dev \
	pkgconf-dev \
	acl-static \
	brotli-static \
	bzip2-static \
	curl-static \
	expat-static \
	libarchive-static \
	lz4-static \
	nghttp2-static \
	openssl-libs-static \
	xz-static \
	zlib-static \
	zstd-static \
	libidn2-static \
	libunistring-static \
	libpsl-static

WORKDIR /src

RUN --mount=type=bind,source=.,target=/src/muon <<EOF
	build=/src/build
	cd /src/muon
	tools/ci/bootstrap.sh "$build" \
		-Dwerror=true \
		-Dlibarchive=enabled \
		-Dlibcurl=enabled \
		-Dlibpkgconf=enabled \
		-Dstatic=true
EOF

FROM base
COPY --from=builder /src/build/muon /usr/bin/muon
