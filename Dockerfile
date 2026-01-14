FROM nginx:1.27.5
LABEL authors="lsh"

# 1) 기본 Nginx 설정 제거
RUN rm /etc/nginx/conf.d/default.conf \
 && rm /etc/nginx/nginx.conf \
 && rm -r /usr/share/nginx

RUN mkdir -p /usr/share/nginx && chmod 755 /usr/share/nginx

# 2) SSL/DH 파라미터(필요 시)
# RUN mkdir -p /etc/nginx/ssl \
#  && openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048

# 3) 사용자 설정 복사
COPY nginx/ /etc/nginx/

# 4) 정적 자산 복사 (이미지 내 포함하고 싶다면 활성화)
# COPY share/ /usr/share/nginx/html/
COPY static/ /var/nginx/static

# 5) 커스텀 entrypoint 복사 및 실행 권한
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# 6) 엔트리포인트 지정
ENTRYPOINT ["docker-entrypoint.sh"]
