dyn.load("/Users/syou6162/RTokyoCabinet/src/tc.so")

hdb <- .Call("new", "casket.hdb")

.Call("put", hdb, "hoge", "fuga")
# .Call("put", hdb, 1, 2)
.Call("put", hdb, "aaa", "bbb")
.Call("get", hdb, "hoge")

.Call("iterinit", hdb)
while(!is.null(item <- .Call("iternext", hdb))) {
  names(item) <- c("key", "value") # modified from R
  print(item)
}

.Call("close", hdb)
