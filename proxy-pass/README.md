# nginx proxy_pass

项目中需要在某个站点嵌入一个新的站点，并且要配置在同一个域以便能获取到原站点的cookie，于是使用nginx来做个简单的路径转发，具体的需求例如：

> 在A站点设置一个额外的路径，假设为`http://A/external`，转发到B站点的根路径`http://B`，那么在访问`http://A/external`（或`http://A/external/index.html`）的时候，就要重定向到`http://B/index.html`，并且在`B/index.html`中的所有资源及子路径都要正确加载

但在配置proxy_pass遇到点问题，不像预期那样生效，并且index.html中加载的脚本也没有正常加载。以前也遇到过但并没有深究，这次梳理记录下~

最新的文档上是这么说的：

> A request URI is passed to the server as follows:

> If the proxy_pass directive is specified with a URI, then when a request is passed to the server, the part of a normalized request URI matching the location is replaced by a URI specified in the directive:
```
location /name/ { // 情况A
    proxy_pass http://127.0.0.1/remote/;
}
```
If proxy_pass is specified without a URI, the request URI is passed to the server in the same form as sent by a client when the original request is processed, or the full normalized request URI is passed when processing the changed URI:
```
location /some/path/ { // 情况B
    proxy_pass http://127.0.0.1;
}
```

如果proxy_pass指明了特定的URI（并且结尾是一个`/`），那么匹配了location的路径部分会被替换成proxy_pass指定的路径，例如上面的情况A，`/name/test.html`会被替换成`http://127.0.0.1/remote/test.html`。

如果proxy_pass没有指定特定的URI，只是指定了host（结尾没有`/`，否则属于情况A），那么匹配了location的路径会完整的添加到proxy_pass指定的主机上，例如上面的情况B，`/some/path/test.html`会转发到`http://127.0.0.1/some/path/test.html`

但如果proxy_pass指定了URI但结尾没有`/`会是什么情况呢？即：
```
location /name/ { // 情况C
    proxy_pass http://127.0.0.1/remote;
}
```

此时`/name/test.html`的请求会变成`http://127.0.0.1/remotetest.html`……
如果把`/name/`改成`/name`，那就更有意思了。

貌似nginx文档上也没明说是否要加`/`，但除非是不指定URI的host转发的情况，或者你明确知道你需要这样做，否则建议在location和proxy_pass最后都加上斜杠。

## 测试
把nginx1.conf里的target改成自己的IP，然后 sh run-proxy.sh，看看nginx log输出的结果就容易看出区别了。



