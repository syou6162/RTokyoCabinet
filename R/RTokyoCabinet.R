TokyoCabinet <- function(filename) {
  result <- .Call("new", filename, PACKAGE="RTokyoCabinet")
  class(result) <- "RTokyoCabinet"
  return(result)
}

TokyoCabinetPut <- function(hdb, key, value) {
  .Call("put", hdb,
        # no connection, converte to ascii
        rawToChar(serialize(key, NULL, TRUE)),
        rawToChar(serialize(value, NULL, TRUE)),
        PACKAGE="RTokyoCabinet")
}

TokyoCabinetGet <- function(hdb, key) {
  unserialize(charToRaw(.Call("get",
                              hdb,
                              rawToChar(serialize(key, NULL, TRUE)),
                              PACKAGE="RTokyoCabinet")))
}

TokyoCabinetIterInit <- function(hdb) {
  .Call("iterinit", hdb, PACKAGE="RTokyoCabinet")
}

TokyoCabinetIterNext <- function(hdb) {
  tmp <- .Call("iternext", hdb, PACKAGE="RTokyoCabinet")
  if(is.null(tmp)){
    return(NULL)
  } else {
    sapply(tmp, function(x) {unserialize(charToRaw(x))})
  }
}

TokyoCabinetClose <- function(hdb) {
  .Call("close", hdb, PACKAGE="RTokyoCabinet")
}

