vcl 4.1;

backend default {
    .host = "flask";
    .port = "8000";
}

sub vcl_backend_response {

    if (bereq.http.Cookie ~ "(UserID|_session)") {
        set beresp.http.X-Cacheable = "NO:Got Session";
        set beresp.uncacheable = true;
        return (deliver);

    } elsif (beresp.ttl <= 0s) {
        # Varnish determined the object was not cacheable
        set beresp.http.X-Cacheable = "NO:Not Cacheable";

    } elsif (beresp.http.set-cookie) {
        # You don't wish to cache content for logged in users
        set beresp.http.X-Cacheable = "NO:Set-Cookie";
        set beresp.uncacheable = true;
        return (deliver);

    } elsif (beresp.http.Cache-Control ~ "private") {
        # You are respecting the Cache-Control=private header from the backend
        set beresp.http.X-Cacheable = "NO:Cache-Control=private";
        set beresp.uncacheable = true;
        return (deliver);

    } else {
        # Varnish determined the object was cacheable
        set beresp.http.X-Cacheable = "YES";
    }

    # ....

    return(deliver);
}
