FROM mambaorg/micromamba:0.8.2
COPY env.yml /root/env.yml
RUN micromamba install -y -n base -f /root/env.yml && \
    rm /opt/conda/pkgs/cache/*

RUN pip install thredds-crawler
RUN pip install pyepsg
RUN pip datashader


WORKDIR /

COPY ./ .

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}
