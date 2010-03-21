#include <tcutil.h>
#include <tchdb.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

#include <R.h> 
#include <Rdefines.h> 
#include <Rinternals.h> 

SEXP new(SEXP filename) {
  TCHDB *hdb;
  int ecode;

  hdb = tchdbnew();

  if(!tchdbopen(hdb, CHAR(STRING_ELT(filename, 0)), HDBOWRITER | HDBOCREAT)){
    ecode = tchdbecode(hdb);
    fprintf(stdout, "open error: %s\n", tchdberrmsg(ecode));
  }

  SEXP Rptr;
  Rptr = R_MakeExternalPtr((void *)hdb, R_NilValue, R_NilValue);
  return Rptr;
};

SEXP close(SEXP Rptr) {
  TCHDB *hdb = (TCHDB*) R_ExternalPtrAddr(Rptr);
  int ecode;

  if(!tchdbclose(hdb)){
    ecode = tchdbecode(hdb);
    fprintf(stdout, "close error: %s\n", tchdberrmsg(ecode));
  }
  if (!hdb) tchdbdel(hdb);
  return R_NilValue;
};

SEXP put(SEXP Rptr, SEXP key, SEXP value) {
  TCHDB *hdb = (TCHDB*) R_ExternalPtrAddr(Rptr);
  int ecode;

  if(!tchdbput2(hdb, CHAR(STRING_ELT(key, 0)), CHAR(STRING_ELT(value, 0)))){
    ecode = tchdbecode(hdb);
    fprintf(stdout, "put error: %s\n", tchdberrmsg(ecode));
  }
  return R_NilValue;
};

SEXP get(SEXP Rptr, SEXP str) {
  TCHDB *hdb = (TCHDB*) R_ExternalPtrAddr(Rptr);
  int ecode;
  char *value;

  SEXP result;

  value = tchdbget2(hdb, CHAR(STRING_ELT(str, 0)));
  if(value){
    result = mkString(value);
    free(value);
  } else {
    ecode = tchdbecode(hdb);
    fprintf(stderr, "get error: %s\n", tchdberrmsg(ecode));
    result = R_NilValue;
  }
  return result;
};

SEXP iterinit(SEXP Rptr) {
  TCHDB *hdb = (TCHDB*) R_ExternalPtrAddr(Rptr);
  tchdbiterinit(hdb);
  return R_NilValue;
};

SEXP iternext(SEXP Rptr) {
  TCHDB *hdb = (TCHDB*) R_ExternalPtrAddr(Rptr);
  char *key, *value;
  if ((key = tchdbiternext2(hdb)) != NULL) {
    SEXP result;
    PROTECT(result = allocVector(STRSXP, 2));

    value = tchdbget2(hdb, key);
    if(value){
      SET_STRING_ELT(result, 0, mkChar(key));
      SET_STRING_ELT(result, 1, mkChar(value));
      //      printf("%s:%s\n", key, value);
      free(value);
    }
    free(key);
    UNPROTECT(1);
    return result;
  } else {
    return R_NilValue;
  }
};

/* SEXP iternext(SEXP Rptr) { */
/*   TCHDB *hdb = (TCHDB*) R_ExternalPtrAddr(Rptr); */
/*   char *key, *value; */
/*   while((key = tchdbiternext2(hdb)) != NULL){ */
/*     value = tchdbget2(hdb, key); */
/*     if(value){ */
/*       printf("%s:%s\n", key, value); */
/*       free(value); */
/*     } */
/*     free(key); */
/*   } */
/*   return R_NilValue; */
/* }; */
