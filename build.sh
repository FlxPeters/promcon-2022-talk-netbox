#! /bin/bash

podman run --rm -v $(pwd):/documents/:z docker.io/asciidoctor/docker-asciidoctor asciidoctor-revealjs \
    -a revealjsdir=https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.9.2  presentation.adoc