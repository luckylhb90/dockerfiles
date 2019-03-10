## `/etc/nginx/conf.d/default.conf` 修改

```
location ~ \.php$ {
    root           html;
    fastcgi_pass   127.0.0.1:9000;
    fastcgi_index  index.php;
    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
    include        fastcgi_params;
}
```

改为

> **NOTE**: 
> php-fpm 要根据实际容器名修改
> $document_root 存储的是 nginx root 路径, 要根据实际 php 容器脚本路径来修改, 
> 如果php里面是：`/var/www/html` , 则改成: `/var/www/html$fastcgi_script_name;`
> 而不是 `$document_root$fastcgi_script_name` 或 修改 `root  /var/www/html;`

```
location ~ \.php$ {
    root           /usr/share/nginx/html;
    fastcgi_pass   php-fpm:9000;
    fastcgi_index  index.php;
    fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
    include        fastcgi_params;
}
```

改成 
```
location ~ \.php$ {
    root           /var/www/html;
    fastcgi_pass   php-fpm:9000;
    fastcgi_index  index.php;
    fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
    include        fastcgi_params;
}
```