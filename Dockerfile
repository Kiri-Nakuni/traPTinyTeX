FROM alpine:latest

COPY ./templates/scripts/build_uplatex /root/bin/build
COPY ./templates/scripts/build_lualatex /root/bin/buildlua
COPY ./templates/scripts/build_xelatex /root/bin/buildxe
COPY .latexmkrc /home/.latexmkrc
COPY ./templates/scripts/template /root/bin/template
COPY ./templates/scripts/templatelua /root/bin/templatelua
COPY ./templates/scripts/templatexe /root/bin/templatexe
COPY ./templates/tex/template.tex /root/bin/template.tex.template
COPY ./templates/tex/templatelua.tex /root/bin/templatelua.tex.template
COPY ./templates/tex/templatexe.tex /root/bin/templatexe.tex.template
COPY ./templates/texts/help.txt /root/bin/help.txt.help
COPY ./templates/texts/start.txt /home/start.txt
COPY ./template/scripts/faq /root/bin/faq

# TeX Liveのインストール設定
COPY texlive.profile /tmp/texlive.profile
COPY texlive.packages /tmp/texlive.packages

ENV PATH="/root/bin:/opt/texlive/2025/bin/x86_64-linuxmusl:${PATH}"

RUN chmod +x /root/bin/build
RUN chmod +x /root/bin/template
RUN chmod +x /root/bin/buildlua
RUN chmod +x /root/bin/templatelua
RUN chmod +x /root/bin/buildxe
RUN chmod +x /root/bin/templatexe
RUN chmod +x /root/bin/faq
RUN apk add --no-cache perl wget fontconfig ca-certificates python3 py3-pip py3-pygments ncurses fzf

# TeX Liveのインストール
RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar -xzf install-tl-unx.tar.gz && \
    cd install-tl-* && \
    perl ./install-tl --profile=/tmp/texlive.profile && \
    cd .. && \
    rm -rf install-tl-* install-tl-unx.tar.gz && \
    rm /tmp/texlive.profile
RUN mkdir -p /usr/share/fonts/truetype/hackgen
RUN mkdir -p /opt/texlive/texmf-local/fonts/truetype/hackgen/
COPY ./hackgen/ /opt/texlive/texmf-local/fonts/truetype/hackgen/
RUN tlmgr update --self
RUN tlmgr install $(cat /tmp/texlive.packages) && \
    rm -rf /tmp/texlive.packages
RUN kanji-config-updmap-sys haranoaji
RUN mktexfmt uplatex
RUN mktexfmt lualatex
RUN mktexfmt xelatex