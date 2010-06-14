\name{RTokyoCabinet-package}
\alias{RTokyoCabinet-package}
\alias{RTokyoCabinet}
\docType{package}
\title{
  TokyoCabinet interface for R
}
\description{
  This package is the interface of TokyoCabinet.
}
\details{
  \tabular{ll}{
    Package: \tab RTokyoCabinet\cr
    Type: \tab Package\cr
    Version: \tab 0.01\cr
    Date: \tab 2010-06-07\cr
    License: \tab What license is it under?\cr
    LazyLoad: \tab yes\cr
  }
}
\author{
  Yasuhisa Yoshida
}
\references{
  http://1978th.net/tokyocabinet/index.html
}
\keyword{ package }
\keyword{ database }
\keyword{ interface }
\examples{
hdb <- TokyoCabinet("casket.hdb")

TokyoCabinetPut(hdb, "key1", "value1")
TokyoCabinetGet(hdb, "key1")

TokyoCabinetPut(hdb, "key", "value1")
TokyoCabinetGet(hdb, "key")

TokyoCabinetPut(hdb, "key2", 1:10)
TokyoCabinetGet(hdb, "key2")

TokyoCabinetPut(hdb, "key3", matrix(1:12, 3, 4))
TokyoCabinetGet(hdb, "key3")

TokyoCabinetPut(hdb, 1:10, "vector")
TokyoCabinetGet(hdb, 1:10)

TokyoCabinetPut(hdb, matrix(1:12, 3, 4), "matrix")
TokyoCabinetGet(hdb, matrix(1:12, 3, 4))

TokyoCabinetIterInit(hdb)

while(!is.null(item <- TokyoCabinetIterNext(hdb))) {
  names(item) <- c("key", "value") # modified from R
  print(item)
}

TokyoCabinetClose(hdb)
}
