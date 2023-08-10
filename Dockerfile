ARG UBUNTU_VERSION=22.04

FROM alpine/git:2.40.1 as repo

RUN git clone --single-branch https://github.com/LostRuins/koboldcpp /koboldcpp

FROM ubuntu:$UBUNTU_VERSION as build

RUN apt-get update && \
    apt-get install -y build-essential python3 python3-pip git

COPY --from=repo /koboldcpp/requirements.txt requirements.txt

RUN pip install --upgrade pip setuptools wheel \
    && pip install -r requirements.txt

WORKDIR /app

COPY --from=repo /koboldcpp .

RUN make

ENV LC_ALL=C.utf8

FROM build as app

ENTRYPOINT ["python3", "koboldcpp.py"]