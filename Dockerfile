FROM cm2network/steamcmd

ENV STEAMAPPID 1026340
ENV STEAMAPP barotrauma
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

USER root

RUN apt-get update && apt-get install -y --no-install-recommends --no-install-suggests wget libicu-dev libcurl4-openssl-dev

USER ${USER}

RUN mkdir -p "${HOMEDIR}/.steam/sdk64" \
    && ln -s "${STEAMCMDDIR}/linux64/steamclient.so" "${HOMEDIR}/.steam/sdk64/steamclient.so"


WORKDIR ${HOMEDIR}

RUN ./steamcmd/steamcmd.sh +login anonymous +force_install_dir "${STEAMAPPDIR}" +app_update 1026340 validate +quit

COPY "entry.sh" .
COPY "serversettings.xml" .
CMD ["./entry.sh"]

# Expose ports
EXPOSE 27015/tcp \
	27015/udp \
	27020/udp \
    27016/udp \
    27016/tcp