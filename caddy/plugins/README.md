# Build Caddy with plugins

Build your own Caddy binary. Since the plugins must be added before you build the binary,
I'm using ``build-arg`` to add the plugins I want.

For example:

```
docker build --build-arg PLUGINS=cache,cloudflare -t douglasmiranda/caddy:cache .
```

As you can see you must provide the plugin names and it must be comma-separated, like: ``plugin-name-1,plugin-name-2,plugin-name-3``.
