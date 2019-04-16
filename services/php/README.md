## 错误整合

### 1

Question:

```
configure: WARNING: ========================================================
configure: WARNING: Use of bundled libzip is deprecated and will be removed.
configure: WARNING: Some features such as encryption and bzip2 are not available.
configure: WARNING: Use system library and --with-libzip is recommended.
configure: WARNING: ========================================================
```

Answer:

> https://stackoverflow.com/questions/48700453/docker-image-build-with-php-zip-extension-shows-bundled-libzip-is-deprecated-w

```
#install some base extensions
RUN apt-get install -y \
        libzip-dev \
        zip \
  && docker-php-ext-configure zip --with-libzip \
  && docker-php-ext-install zip
```


### 2

A: warning
> warning: mbstring (mbstring.so) is already loaded!  
> php:7.2-fpm

Q: 去除下面指令即可
```
docker-php-ext-install mbstring
```


