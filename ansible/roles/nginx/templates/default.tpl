server {
    server_name {{ domain_name }};
    root {{ doc_root }};

    location / {
{% if project_type == 'laravel' %}try_files $uri /index.php$is_args$args;{% endif %}
{% if project_type == 'symfony' and mode == 'dev' %}try_files $uri /app_dev.php$is_args$args;{% endif %}
{% if project_type == 'symfony' and mode == 'prod' %}try_files $uri /app.php$is_args$args;{% endif %}
    }

    {% if project_type == 'laravel' %}
location ~ ^/index\.php(/|$) {
    {% endif %}
    {% if project_type == 'symfony' and mode == 'dev' %}
location ~ ^/(app_dev|config)\.php(/|$) {
    {% endif %}
    {% if project_type == 'symfony' and mode == 'prod' %}
location ~ ^/app\.php(/|$) {
    {% endif %}
        fastcgi_pass unix:/var/run/php/php{{ php_version }}-fpm.sock;
        fastcgi_split_path_info ^(.+\.php)(/.*)$;
        include fastcgi_params;
        fastcgi_param  SCRIPT_FILENAME  $realpath_root$fastcgi_script_name;
        fastcgi_param DOCUMENT_ROOT $realpath_root;
    }

    # Media: images, icons, video, audio, HTC

    location ~* \.(?:jpg|jpeg|gif|png|ico|cur|gz|svg|svgz|mp4|ogg|ogv|webm|htc|woff2)$ {
        expires 1M;
        access_log off;
        add_header Cache-Control "public";
    }

    # CSS and Javascript

    location ~* \.(?:css|js)$ {
        expires 1y;
        access_log off;
        add_header Cache-Control "public";
    }

    error_log /var/log/nginx/project_error.log;
    access_log /var/log/nginx/project_access.log;

    client_max_body_size 100m;

    gzip on;
    gzip_disable "msie6";
    gzip_comp_level 6;
    gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;
}