FROM r-base:latest
#FROM r-base:hiroshi

WORKDIR /workdir

RUN apt update
RUN apt upgrade -y
RUN apt install -y libssl-dev libxml2-dev libcurl4-openssl-dev r-base-core r-base-dev r-cran-curl r-cran-openssl r-cran-xml2 xclip
RUN apt clean 

####################日本語環境設定####################
ENV LANG ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
RUN sed -i '$d' /etc/locale.gen \
  && echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen ja_JP.UTF-8 \
    && /usr/sbin/update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
RUN /bin/bash -c "source /etc/default/locale"
RUN ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# 日本語フォントをインストール
RUN apt-get update && apt-get install -y \
  fonts-ipaexfont \
  fonts-noto-cjk
######################################################

RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('gt')"
 OS環境（rockerはdebianベース）に日本語ロケールを追加し切り替え

