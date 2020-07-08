FROM node:buster

RUN curl https://cli-assets.heroku.com/install-ubuntu.sh | sh && \
	apt-get install -y python3 python3-pip ca-certificates openssl && \
	pip3 install --upgrade PyOpenSSL && \
	pip3 install --upgrade certbot-dns-cloudflare && \
	rm -rf /var/lib/apt/lists/*

COPY run_certbot.sh /root/

ENTRYPOINT [ "/root/run_certbot.sh" ]

