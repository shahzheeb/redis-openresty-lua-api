# redis-openresty-lua-api
This API is created as reference to show how to integrate openresty, Shared cache and Redis.

1. Install Luarocks ```brew install luarocks```
2. Initialize luarocks ```luarocks init```
3. Install router module ```luarocks install router```
4. Add path to the lua_module to in your lua_package_path e.g ```lua_package_path ";;/usr/local/Cellar/openresty/1.13.6.2/lualib/resty/lua_modules/share/lua/5.3/?.lua;/Users/shahzheeb/Documents/Reference-Projects/redis-openresty-lua-api/lua/?.lua";```

Start the app: ```openresty -p `pwd`/ -c conf/nginx.conf```

Stop the app: ```openresty -s stop```

Please follow this link for installation and commands: https://github.com/shahzheeb/openresty-lua-apis/blob/master/README.md

