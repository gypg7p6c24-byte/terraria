FROM debian:bookworm-slim

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        wget \
        lib32gcc-s1 \
        lib32stdc++6 \
        unzip \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m steam

USER steam
WORKDIR /home/steam

# Install SteamCMD
RUN mkdir steamcmd \
    && cd steamcmd \
    && wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz \
    && tar -xvzf steamcmd_linux.tar.gz \
    && rm steamcmd_linux.tar.gz

# Install Terraria Dedicated Server (AppID 105600)
RUN ./steamcmd/steamcmd.sh +login anonymous \
    +force_install_dir /home/steam/terraria \
    +app_update 105600 validate \
    +quit

WORKDIR /home/steam/terraria

EXPOSE 7777

COPY --chown=steam:steam entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
