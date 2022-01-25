# Tzdata Proxied HTTP Client

这是一个走代理的 `Tzdata.HTTPClient`，
目的是让 Tzdata 能通过代理来自动更新时区数据库。

## 安装

```elixir
def deps do
  [
    {:tzdata_proxied_http_client, git: "https://github.com/Aetherus/tzdata_proxied_http_client.git", branch: "master"}
  ]
end
```

## 配置

在 `config.exs` 或等效配置文件中添加

```
config :tzdata,
  http_client: TzdataProxiedHttpClient,
  autoupdate: :enabled

config tzdata_proxied_http_client,
  proxy: {:http, "192.168.x.x", 8080, []}  # HTTP 代理服务器的 IP 和端口
```

## 注意事项

- 本客户端只支持 HTTP 和 HTTPS 代理，建议使用 HTTP 代理。
- 如果使用 HTTP 代理，则该代理必须支持 HTTP 隧道，且必须严格遵守 RFC-7231 中 CONNECT 请求的规范。

## 参考资料

- [RFC-7231#CONNECT](https://httpwg.org/specs/rfc7231.html#CONNECT)
- [HTTP 隧道](https://zh.wikipedia.org/wiki/HTTP%E9%9A%A7%E9%81%93)
- [用于展示 HTTP 隧道机制的代理服务器实现（Elixir）](https://github.com/Aetherus/my_http_proxy)

