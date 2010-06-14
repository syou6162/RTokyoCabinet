library(RUnit)
library(RTokyoCabinet)

## srcPath <- "../R/"
## fn <- list.files(srcPath, pattern="R$")
## for (k in 1:length(fn)) source(paste(srcPath,fn[k],sep=""))

test.RTokyoCabinetGet1 <- function() {
  hdb <- TokyoCabinet("casket.hdb")
  key <- "key"; value <- "value"
  TokyoCabinetPut(hdb, key, value)
  checkEquals(TokyoCabinetGet(hdb, key), value)
  TokyoCabinetClose(hdb)
}

test.RTokyoCabinetGet2 <- function() {
  hdb <- TokyoCabinet("casket.hdb")
  key <- "key"; value <- 1:10
  TokyoCabinetPut(hdb, key, value)
  checkEquals(TokyoCabinetGet(hdb, key), value)
  TokyoCabinetClose(hdb)
}

test.RTokyoCabinetGet3 <- function() {
  hdb <- TokyoCabinet("casket.hdb")
  key <- "key"; value <- matrix(1:12, 3, 4)
  TokyoCabinetPut(hdb, key, value)
  checkEquals(TokyoCabinetGet(hdb, key), value)
  TokyoCabinetClose(hdb)
}

test.RTokyoCabinetGet4 <- function() {
  hdb <- TokyoCabinet("casket.hdb")
  key <- 1:10; value <- "vector"
  TokyoCabinetPut(hdb, key, value)
  checkEquals(TokyoCabinetGet(hdb, key), value)
  TokyoCabinetClose(hdb)
}

test.RTokyoCabinetGet4 <- function() {
  hdb <- TokyoCabinet("casket.hdb")
  key <- matrix(1:12, 3, 4); value <- "matrix"
  TokyoCabinetPut(hdb, key, value)
  checkEquals(TokyoCabinetGet(hdb, key), value)
  TokyoCabinetClose(hdb)
}

## test.RTokyoCabinetGet5 <- function() {
##   hdb <- TokyoCabinet("casket.hdb")

##   N <- 3
##   keys <- paste("key", 1:N, sep="")
##   values <- paste("value", 1:N, sep="")

##   sapply(1:N, function(i) {
##     TokyoCabinetPut(hdb, keys[i], values[i])
##   })

##   TokyoCabinetIterInit(hdb)

##   result_keys <- c()
##   result_values <- c()
  
##   while(!is.null(item <- TokyoCabinetIterNext(hdb))) {
##     result_keys <- c(result_keys, item[1])
##     result_values <- c(result_values, item[2])
##   }
  
##   checkEquals(keys, result_keys)
##   checkEquals(values, result_values)
##   TokyoCabinetClose(hdb)
## }
