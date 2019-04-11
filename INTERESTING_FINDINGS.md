### Interesting Findings

1.  This piece of code in conf file will not print the log statement in error.log even if the log level is set to debug.


```init_by_lua_block {

  ngx.log(ngx.DEBUG, "Starting init_by_lua_block")

} 
```
After Adding this ```lua_shared_dict tmp 12k;```, I was able to see the log statement in init_by_lua_block. 
According to this github issue - "Yes, the presence of lua_shared_dict postpones the execution of the init_by_lua* handler after nginx initializes all its shm zones."

https://github.com/openresty/lua-nginx-module/issues/467

2.  