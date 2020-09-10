FROM cm2network/steamcmd

ENV STEAMAPPID 1026340
ENV STEAMAPP barotrauma
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

USER root

RUN apt-get update && apt-get install -y --no-install-recommends --no-install-suggests wget libicu-dev

#RUN wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
#    && dpkg -i packages-microsoft-prod.deb

USER ${USER}

RUN mkdir -p "${STEAMAPPDIR}"

RUN ${STEAMCMDDIR}/steamcmd.sh +login anonymous \
				+force_install_dir "${STEAMAPPDIR}" \
				+app_update "${STEAMAPPID}" \
				+quit

COPY /serversettings.xml "${STEAMAPPDIR}"

USER steam

RUN mkdir -p "${HOMEDIR}/.steam/sdk64" \
    && ln -s "${STEAMCMDDIR}/linux64/steamclient.so" "${HOMEDIR}/.steam/sdk64/steamclient.so"

USER ${USER}

VOLUME ${STEAMAPPDIR}

WORKDIR ${STEAMAPPDIR}

CMD ["./DedicatedServer"]

# Expose ports
EXPOSE 27015/tcp \
	27015/udp \
	27020/udp \
    27016/udp \
    27016/tcp