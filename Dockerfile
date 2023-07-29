FROM public.ecr.aws/awsguru/php:devel.82.2023.3.13.1-arm64 as builder

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

# Create /mnt/wordpress
RUN mkdir -p /mnt/wordpress

COPY ./app /mnt/wordpress

WORKDIR /mnt/wordpress

# Copy keys to /var/task/keys
RUN mkdir -p /mnt/wordpress/keys

COPY ./keys/cert.pem /mnt/wordpress/keys/cert.pem
COPY ./keys/key.pem /mnt/wordpress/keys/key.pem

# Production build (Smaller Image Size)
FROM public.ecr.aws/awsguru/php:devel.82.2023.3.13.1-arm64
COPY --from=inspectorgadget12/lambda-runtime-adapter /lambda-runtime-adapter /opt/extensions/lambda-adapter
COPY --from=builder /mnt/wordpress /mnt/wordpress

# config files
ADD ./lambda-runtime/nginx/conf/nginx.conf      /opt/nginx/conf/nginx.conf
ADD ./lambda-runtime/php/php.ini                /opt/php/php.ini
ADD ./lambda-runtime/php/etc/php-fpm.conf       /opt/php/etc/php-fpm.conf
ADD ./lambda-runtime/php/php.d/extensions.ini   /opt/php/php.d/extensions.ini

COPY ./lambda-runtime/bootstrap                 /opt/bootstrap

ENTRYPOINT /opt/bootstrap