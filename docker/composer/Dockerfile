FROM composer/composer

ARG PACKAGE_NAME
ENV PACKAGE_NAME=$PACKAGE_NAME

COPY /package /package

RUN <<EOT
    composer create-project laravel/laravel /app
EOT

RUN <<EOT
    echo ${PACKAGE_NAME}
    composer config repositories.package  '{ "type": "path", "url": "/package", "options": { "symlink": false } }'
    composer require ${PACKAGE_NAME}
EOT

CMD composer reinstall ${PACKAGE_NAME}
