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

> 其中 phpfpm 根据实际容器名修改

```
location ~ \.php$ {
    root           /usr/share/nginx/html;
    fastcgi_pass   phpfpm:9000;
    fastcgi_index  index.php;
    fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
    include        fastcgi_params;
}
```