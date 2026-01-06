FROM alpine:latest

COPY /fsroot/bin/ /root/bin/
COPY /fshome/ /home/
COPY /fstmp/ /tmp/

ENV PATH="/root/bin:/opt/texlive/2025/bin/x86_64-linuxmusl:${PATH}"

RUN chmod +x /root/bin/build && chmod +x /root/bin/template && chmod +x /root/bin/faq && \
    apk add --no-cache nodejs npm perl wget fontconfig ca-certificates vim python3 py3-pip py3-pygments fzf

# TeX Liveのインストール
RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar -xzf install-tl-unx.tar.gz && \
    cd install-tl-* && \
    perl ./install-tl --profile=/tmp/texlive.profile && \
    cd .. && \
    rm -rf install-tl-* install-tl-unx.tar.gz
RUN fc-cache -fv && mktexfmt uplatex.fmt && tlmgr update --self && tlmgr install $(cat /tmp/texlive.packages)