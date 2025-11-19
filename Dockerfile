FROM alpine:latest

COPY build_uplatex /root/bin/build
COPY .latexmkrc /home/.latexmkrc
COPY template /root/bin/template
COPY template.tex /root/bin/template.tex.template
COPY help.txt /root/bin/help.txt.help
COPY start.txt /home/start.txt

# TeX Liveのインストール設定
COPY texlive.profile /tmp/texlive.profile
COPY texlive.packages /tmp/texlive.packages

ENV PATH="/root/bin:/opt/texlive/2025/bin/x86_64-linuxmusl:${PATH}"

RUN chmod +x /root/bin/build
RUN chmod +x /root/bin/template
RUN apk add --no-cache nodejs npm perl wget fontconfig ca-certificates vim python3 py3-pip py3-pygments

# TeX Liveのインストール
RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar -xzf install-tl-unx.tar.gz && \
    cd install-tl-* && \
    perl ./install-tl --profile=/tmp/texlive.profile && \
    cd .. && \
    rm -rf install-tl-* install-tl-unx.tar.gz
RUN mkdir -p /usr/share/fonts/truetype/hackgen
RUN mkdir -p /opt/texlive/texmf-local/fonts/truetype/hackgen/
COPY ./hackgen/* /opt/texlive/texmf-local/fonts/truetype/hackgen/*
COPY ./hackgen/*    /usr/share/fonts/truetype/hackgen/*
RUN fc-cache -fv
RUN mktexfmt uplatex.fmt
RUN tlmgr update --self
RUN tlmgr install $(cat /tmp/texlive.packages)