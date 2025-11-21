FROM alpine:latest

COPY templateatc /root/bin/templateatc
COPY atctex /root/bin/atctex
COPY atctemplate.tex /root/bin/atctemplate.tex.template
COPY start.txt /home/start.txt

# TeX Liveのインストール設定
COPY texlive.profile /tmp/texlive.profile
COPY texlive.packages /tmp/texlive.packages

ENV PATH="/root/bin:/opt/texlive/2025/bin/x86_64-linuxmusl:${PATH}"
RUN chmod +x /root/bin/templateatc
RUN chmod +x /root/bin/atctex
RUN apk add --no-cache perl wget ca-certificates

# TeX Liveのインストール
RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar -xzf install-tl-unx.tar.gz && \
    cd install-tl-* && \
    perl ./install-tl --profile=/tmp/texlive.profile && \
    cd .. && \
    rm -rf install-tl-* install-tl-unx.tar.gz
RUN tlmgr update --self
RUN tlmgr install $(cat /tmp/texlive.packages)
RUN mktexfmt tex.fmt