# escape=`
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

#COPY --chown=DODS:root /sourcemod.linux /app/dod

#COPY --chown=DODS:root /sourcemod-configs /app/dod

COPY --chown=DODS:root /dist /app

COPY --chown=DODS:root /dist/linux/ll-tests /app/ll-tests

RUN usermod -l DODSLeague DODS &&`
    chmod +x /app/ll-tests/*.sh;

USER DODSLeague

ONBUILD USER root
