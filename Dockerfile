#   BUILD_ARCH and BUILD_VERSION are supplied automatically by
#   home-assistant/builder/actions/build-image. BUILD_FROM is no longer
#   injected, so the per-arch HA base is selected from BUILD_ARCH directly.

ARG BUILD_ARCH=amd64

#   Choose right Microsoft build image & runtime for architecture

FROM mcr.microsoft.com/dotnet/sdk:9.0-alpine AS dotnet-builder-amd64
ENV runtime=linux-musl-x64

FROM mcr.microsoft.com/dotnet/sdk:9.0-alpine AS dotnet-builder-i386
ENV runtime=linux-musl-x86

FROM mcr.microsoft.com/dotnet/sdk:9.0-alpine AS dotnet-builder-aarch64
ENV runtime=linux-musl-arm64

FROM mcr.microsoft.com/dotnet/sdk:9.0-alpine AS dotnet-builder-armv7
ENV runtime=linux-musl-arm

#   Use it to build our project self-contained
#   (with all dependencies, including dotnet runtime)

FROM dotnet-builder-${BUILD_ARCH} AS dotnet-builder
ARG BUILD_VERSION="0.0.0"
COPY Ozric /src
RUN echo "Ozric version: ${BUILD_VERSION}"
RUN dotnet publish -c Release -r ${runtime} --self-contained /src/Ozric.Dashboard/Ozric.Dashboard.csproj -o "/ozric" /property:Version=${BUILD_VERSION}

#   Build the final image, pulling the per-arch Home Assistant base directly.

FROM ghcr.io/home-assistant/${BUILD_ARCH}-base:latest
RUN apk add --no-cache \
    openssh libunwind \
    nghttp2-libs libidn krb5-libs libuuid lttng-ust zlib \
    libstdc++ libintl \
    icu

COPY rootfs /
COPY --from=dotnet-builder /ozric /ozric

EXPOSE 8099
