# escape=`

FROM debian:bullseye-slim AS builder
ARG SMVERSIOM=1.10
ARG MMVERSIOM=1.10
WORKDIR /dl

RUN apt-get update && apt-get install -y `
    wget jq unzip &&`
    apt-get clean &&`
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*;

RUN wget "https://sm.alliedmods.net/smdrop/$SMVERSIOM/$(wget -qO- https://sm.alliedmods.net/smdrop/$SMVERSIOM/sourcemod-latest-linux)"
RUN wget "https://mms.alliedmods.net/mmsdrop/$MMVERSIOM/$(wget -qO- https://mms.alliedmods.net/mmsdrop/$MMVERSIOM/mmsource-latest-linux)"
RUN wget "$(wget -qO- https://api.github.com/repos/DODSLeague/dodhooks/releases | jq -r 'map(select(.prerelease)) | first | .assets[0].browser_download_url')"


RUN mkdir /dl/sm && tar -xvzf sourcemod*.tar.gz -C /dl/sm
RUN mkdir /dl/mm && tar -xvzf mmsource*.tar.gz -C /dl/mm
RUN mkdir /dl/dh && unzip dodhooks.zip -d /dl/dh

FROM lacledeslan/gamesvr-dods
HEALTHCHECK NONE
ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified


LABEL com.lacledeslan.build-node=$BUILDNODE `
      org.label-schema.schema-version="1.0" `
      org.label-schema.url="https://dodsleague.eu" `
      org.label-schema.vcs-ref=$SOURCE_COMMIT `
      org.label-schema.vendor="DODSLeague" `
      org.label-schema.description="DODSLeague Day of Defeat Dedicated competitive Server" `
      org.label-schema.vcs-url="https://github.com/DODSLeague/dods-competitive"

COPY --chown=DODS:root --from=builder /dl/sm /app/dod
COPY --chown=DODS:root --from=builder /dl/mm /app/dod
COPY --chown=DODS:root --from=builder /dl/dh/release /app/dod

#COPY --chown=DODS:root /sourcemod-configs /app/dod

COPY --chown=DODS:root /dist /app
RUN rm -rf /app/bin/libstdc++.so.6

COPY --chown=DODS:root /dist/linux/ll-tests /app/ll-tests

RUN usermod -l DODSLeague DODS &&`
    chmod +x /app/ll-tests/*.sh;

USER DODSLeague

ONBUILD USER root
