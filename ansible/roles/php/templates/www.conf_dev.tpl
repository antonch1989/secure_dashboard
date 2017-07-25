[www]
user = vagrant
group = vagrant

listen = /run/php/php{{ php_version }}-fpm.sock
listen.owner = vagrant
listen.group = vagrant
listen.mode = 0660

pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3