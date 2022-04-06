FROM rocker/shiny-verse:latest

RUN apt-get update -qq \
    && apt-get -y --no-install-recommends install \
        libudunits2-dev \
        libgdal-dev \
        libgeos-dev \
        libproj-dev \
        libsodium-dev \
    && install2.r --error --deps TRUE \
        markdown \
        shiny \
        shinythemes \
        leaflet \
        magrittr \
        shinycssloaders \
        leaflet.extras \
        viridisLite \
        shinymanager \
    && installGithub.r r-spatial/leafgl \
        r-spatial/leafem \
