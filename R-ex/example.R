tc_new <- function(filename) {
  .Call("new", filename)
}

tc_put <- function(hdb, key, value) {
  .Call("put", hdb,
        # no connection, converte to ascii
        rawToChar(serialize(key, NULL, TRUE)),
        rawToChar(serialize(value, NULL, TRUE)))
}

tc_get <- function(hdb, key) {
  unserialize(charToRaw(.Call("get", hdb, rawToChar(serialize(key, NULL, TRUE)))))
}

tc_iterinit <- function(hdb) {
  .Call("iterinit", hdb)
}

tc_close <- function(hdb) {
  .Call("close", hdb)
}

tc_iternext <- function(hdb) {
  tmp <- .Call("iternext", hdb)
  if(is.null(tmp)){
    return(NULL)
  } else {
    sapply(tmp, function(x) {unserialize(charToRaw(x))})
  }
}

##########
# Example 
##########
dyn.load("~/RTokyoCabinet/src/tc.so")

hdb <- tc_new("casket.hdb")

tc_put(hdb, "key1", "value1")
tc_get(hdb, "key1")

tc_put(hdb, "key", "value1")
tc_get(hdb, "key")

tc_put(hdb, "key2", 1:10)
tc_get(hdb, "key2")

tc_put(hdb, "key3", matrix(1:12, 3, 4))
tc_get(hdb, "key3")

tc_put(hdb, 1:10, "vector")
tc_get(hdb, 1:10)

tc_put(hdb, matrix(1:12, 3, 4), "matrix")
tc_get(hdb, matrix(1:12, 3, 4))

tc_iterinit(hdb)

while(!is.null(item <- tc_iternext(hdb))) {
  names(item) <- c("key", "value") # modified from R
  print(item)
}

tc_close(hdb)
