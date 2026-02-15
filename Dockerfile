FROM debian:bookworm-slim

# ------------ Install system deps ------------
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        wget \
        unzip \
        mono-runtime \
        mono-devel \
        libmono-system-core4.0-cil \
        libmono-system-data-datasetextensions4.0-cil \
        libmono-system-xml-linq4.0-cil \
        libmono-system-management4.0-cil \
        libmono-system-runtime-serialization4.0-cil \
        libmono-system-servicemodel-internals0.0-cil \
        libmono-system-data4.0-cil \
        libmono-system-web-extensions4.0-cil && \
    rm -rf /var/lib/apt/lists/*

# ------------ Create steam user ------------
RUN useradd -m steam
USER steam
WORKDIR /home/steam

# ------------ Install SteamCMD ------------
RUN mkdir -p /home/steam/steamcmd && \
    cd steamcmd && \
    wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
    tar -xvzf steamcmd_linux.tar.gz && \
    rm steamcmd_linux.tar.gz

# ------------ Download Terraria (Windows) via SteamCMD ------------
RUN /home/steam/steamcmd/steamcmd.sh +login anonymous \
    +force_install_dir /home/steam/terraria \
    +app_update 105600 validate \
    +quit

# ------------ Expose default Terraria port ------------
EXPOSE 7777

# ------------ Copy entrypoint ------------
COPY --chown=steam:steam entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
