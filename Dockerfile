FROM cm2network/steamcmd

ENV STEAMAPPID 1026340
ENV STEAMAPP barotrauma
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

USER root

RUN apt-get update && apt-get install -y --no-install-recommends --no-install-suggests wget libicu-dev libcurl4-openssl-dev

USER steam

# Barotrauma currently looks for the steamclient in this location (2020/09/12)
RUN mkdir -p "${HOMEDIR}/.steam/sdk64" \
    && ln -s "${STEAMCMDDIR}/linux64/steamclient.so" "${HOMEDIR}/.steam/sdk64/steamclient.so"

WORKDIR ${HOMEDIR}

RUN ./steamcmd/steamcmd.sh +login anonymous +force_install_dir "${STEAMAPPDIR}" +app_update ${STEAMAPPID} validate +quit

COPY "entry.sh" .
COPY --chown=steam "serversettings.xml" ${STEAMAPPDIR}
COPY --chown=steam "clientpermissions.xml" ${STEAMAPPDIR}/Data/
COPY --chown=steam "Submarines/*" ${STEAMAPPDIR}/Submarines/
CMD ["./entry.sh"]

EXPOSE 27015/tcp
EXPOSE 27015/udp
EXPOSE 27016/tcp
EXPOSE 27016/udp