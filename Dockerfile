FROM alpine:latest
RUN apk add --no-cache perl wget fontconfig ca-certificates python3 py3-pip py3-pygments ncurses fzf
COPY ./fstmp/ /tmp/
COPY ./hackgen/ /opt/texlive/texmf-local/fonts/truetype/hackgen/
ENV PATH="/root/bin:${PATH}"
# 3. TeX Liveのインストール（変更頻度：低・処理時間：長）
#    PATHの設定を考慮し、/usr/local/bin 等へのシンボリックリンク作成をインストーラに任せる設定が profile にあるとベストですが、
#    ここでは手動PATH設定を維持しつつ、不要ファイルの削除を徹底します。
RUN wget -qO- http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | tar -xz -C /tmp && \
    cd /tmp/install-tl-* && \
    perl ./install-tl --profile=/tmp/texlive.profile && \
    tlmgr update --self && \
    tlmgr install $(cat /tmp/texlive.packages) && \
    rm -rf /tmp/install-tl-* /tmp/texlive.profile /tmp/texlive.packages && \
    kanji-config-updmap-sys haranoaji && \
    mktexfmt uplatex && \
    mktexfmt lualatex && \
    mktexfmt xelatex && \
    fc-cache -fv

COPY --chmod=755 ./fsroot/bin/ /root/bin/
COPY ./fshome/ /home/