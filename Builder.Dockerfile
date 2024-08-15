FROM composer/composer

ARG PACKAGE_NAME
ENV PACKAGE_NAME=$PACKAGE_NAME

ARG PACKAGE_PATH
ENV PACKAGE_PATH=$PACKAGE_PATH

RUN echo ${PACKAGE_NAME}
RUN echo ${PACKAGE_PATH}

COPY --from=package . /package

RUN composer create-project laravel/laravel /app

RUN composer config repositories.package  '{ "type": "path", "url": "/package", "options": { "symlink": false } }'
RUN composer require ${PACKAGE_NAME}

CMD composer reinstall ${PACKAGE_NAME}
