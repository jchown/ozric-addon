#   Arguments supplied by Home Assistant

ARG BUILD_FROM   
ARG BUILD_ARCH

#   Choose right Microsoft build image & runtime for architecture

FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS dotnet-builder-amd64
ENV runtime=linux-musl-x64

FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS dotnet-builder-i386
ENV runtime=linux-musl-x86

FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS dotnet-builder-aarch64
ENV runtime=linux-musl-arm64

FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS dotnet-builder-armv7
ENV runtime=linux-musl-arm

#   Use it to build our project self-contained
#   (with all dependencies, including dotnet runtime)

FROM dotnet-builder-${BUILD_ARCH} AS dotnet-builder
COPY Ozric /src
RUN dotnet publish -c Release -r ${runtime} --self-contained /src/OzricUI/OzricUI.csproj -o "/ozric"

#   Build the final image, base image as specified by Home Assistant's builder

FROM $BUILD_FROM
RUN apk add --no-cache \ 
    openssh libunwind \
    nghttp2-libs libidn krb5-libs libuuid lttng-ust zlib \
    libstdc++ libintl \
    icu

COPY rootfs /
COPY --from=dotnet-builder /ozric /ozric

EXPOSE 8099