FROM alpine:latest
COPY texlive /opt/texlive
COPY build_uplatex /root/bin/build
COPY .latexmkrc /home/.latexmkrc
COPY template /root/bin/template
COPY template.tex /root/bin/template.tex.template
COPY help.txt /root/bin/help.txt.help
COPY start.txt /home/start.txt
RUN chmod +x /root/bin/build
RUN chmod +x /root/bin/template
RUN apk add --no-cache nodejs npm perl wget fontconfig ca-certificates vim python3 py3-pip py3-pygments
ENV PATH="/root/bin:/opt/texlive/2025/bin/x86_64-linuxmusl:${PATH}"

RUN mkdir -p /usr/share/fonts/truetype/hackgen
COPY ./hackgen/HackGen-Regular.ttf /usr/share/fonts/truetype/hackgen/
COPY ./hackgen/HackGen-Bold.ttf    /usr/share/fonts/truetype/hackgen/
RUN fc-cache -fv
RUN mktexfmt uplatex.fmt
RUN tlmgr update --self
RUN tlmgr install simplekv cmathbb