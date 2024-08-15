FROM composer/composer

ARG PACKAGE_NAME
ENV PACKAGE_NAME=$PACKAGE_NAME

ARG PACKAGE_PATH
ENV PACKAGE_PATH=$PACKAGE_PATH

RUN echo ${PACKAGE_NAME}
RUN echo ${PACKAGE_PATH}

COPY --from=package . /package

RUN <<EOT
    composer create-project laravel/laravel /app
EOT

RUN <<EOT
    composer config repositories.package  '{ "type": "path", "url": "/package", "options": { "symlink": false } }'
    composer require ${PACKAGE_NAME}
EOT

CMD composer reinstall ${PACKAGE_NAME}
