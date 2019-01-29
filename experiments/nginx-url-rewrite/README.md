# Nginx sub_filter module

https://nginx.org/en/docs/http/ngx_http_sub_module.html

This nginx module is very useful when you want to find and replace strings in a response before presenting to the user.

Note: check `sub_filter_types` to control what response you want to change. By default it only analyses `text/html` responses, in some cases you want to change hard coded urls in a `text/css` response.

## Notes on sub_filter usage with proxy

My example is just a simple find and replace in a static html file response.

But you'll probably need to use `sub_filter` in order to change a proxy response. In this case, the response could be already gzipped, if that's the case you'll need to set `proxy_set_header Accept-Encoding "";`.

Example:

```nginx
location / {
    proxy_set_header Accept-Encoding "";
    proxy_pass http://upstream.site/;
    sub_filter_types *;
    sub_filter_once off;
    sub_filter "hello" "world";
}
```
- https://stackoverflow.com/questions/31893211/http-sub-module-sub-filter-of-nginx-and-reverse-proxy-not-working
