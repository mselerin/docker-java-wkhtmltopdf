FROM surnet/alpine-wkhtmltopdf:3.12-0.12.6-small as wkhtmltopdf
FROM adoptopenjdk/openjdk11:alpine-jre

# Install dependencies for wkhtmltopdf
RUN apk add --no-cache \
    libstdc++ \
    libx11 \
    libxrender \
    libxext \
    libssl1.1 \
    ca-certificates \
    fontconfig \
    freetype \
    ttf-dejavu \
    ttf-droid \
    ttf-freefont \
    ttf-liberation \
    ttf-ubuntu-font-family \
    && apk add --no-cache --virtual .build-deps \
    msttcorefonts-installer \
    \
    # Install microsoft fonts
    && update-ms-fonts \
    && fc-cache -f \
    \
    # Clean up when done
    && rm -rf /tmp/* \
    && apk del .build-deps

# Copy wkhtmltopdf files from docker-wkhtmltopdf image
COPY --from=wkhtmltopdf /bin/wkhtmltopdf /bin/wkhtmltopdf
