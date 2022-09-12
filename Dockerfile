FROM python:3.10

ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    CPLUS_INCLUDE_PATH=/usr/include/gdal \
    C_INCLUDE_PATH=/usr/include/gdal

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wkhtmltopdf \
    gdal-bin \
    libgdal-dev \
    graphviz \
    libgraphviz-dev \
    pkg-config

# <=58 will support use_2to3 -> https://stackoverflow.com/questions/69100275/error-while-downloading-the-requirements-using-pip-install-setup-command-use-2
RUN pip install setuptools==58
RUN pip install GDAL==$(gdal-config --version) poetry==1.1.14


ENTRYPOINT ["./docker-entrypoint.sh"]
