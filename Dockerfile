FROM ubuntu:20.04 AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    gfortran \
    git \
    make \
    p7zip-full \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone --depth 1 --branch "v7.0.9" "https://github.com/LI-COR-Environmental/eddypro-engine.git" engine

WORKDIR /app/engine/prj
RUN make rp && make fcc

FROM debian:bookworm-slim AS runtime

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    libgfortran5 \
    p7zip-full \
    && rm -rf /var/lib/apt/lists/*

ARG IMAGE_VERSION="0.1.0"

LABEL org.opencontainers.image.title="eddypro-engine" \
      org.opencontainers.image.version="${IMAGE_VERSION}" \
      org.opencontainers.image.source="https://github.com/NERC-CEH/eddypro-engine-image"

COPY --from=builder /app/engine/bin/linux /opt/eddypro/bin

ENV PATH="/opt/eddypro/bin:${PATH}"
