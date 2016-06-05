# Generate Static Websites

This page describes the features of **BSD Owl Scripts** that are
useful when generating static websites with
[James Clark's SGML normalizer *onsgmls*][open-sp].  After reading
this page, you will know:

 - How to generate a static website with *onsgmls*
 - How to publish it.

A minimal examples for a website can be found under
[example/www][example-www], it is an historic version of the
**BSD Owl Scripts** website.


## Generate a simple static HTML document

Generating a simple static HTML document require building a `Makefile`
that enumerates the document to generate using the variable *WWW*,
their SGML sources in *SRCS* and mention the document entry point in
*WWWMAIN* if *WWW* has only one document or *WWWMAIN.document* for
each *document* enumerated in *WWW*.  This is illustrate by the
following example:

```Makefile
WWW=		index.html
WWWMAIN=	main.sgml

SRCS=		main.sgml
SRCS+=		head-css-global.sgml
SRCS+=		more-news.sgml
SRCS+=		copyright-statement.sgml

.include "www.sgml.mk"
```

The installation of the document should probably use the identity of
the UNIX user used by the dæmon, we could therefore add the following
declarations to the above `Makefile`:

```Makefile
WWWOWN=		www
WWWGRP=		www
WWWDIR=		/var/www/my_site
```


## Parameter entities

As demonstrated by the following snippet, the DTD can be extended to
define additional entities and parameter entities:

```sgml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" [
<!ENTITY software-current-version "1.4">
<!ENTITY copyright-statement SYSTEM "copyright-statement.sgml">
<!ENTITY % with.head-css-local "IGNORE">
]>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>&head-title;</title>
&head-css-global;
<![ %with.head-css-local [
&head-css-local;
]]>
</head>
<body>
…
</body>
</html>
```

When using **BSD Owl Scripts** that are to generating static websites
it is possible to enumerate the list of parameter entities that need
to be set to `INCLUDE` instead of `IGNORE` using the `SGML_INCLUDE`
variable for this.


## Files spread accross several directories

The variable *DIRS* enumerates directories where the SGML normalizer
search for the files it needs.


## Additional catalogs

Additional catalogs should be enumerated by the *CATALOG* variable.


## Generate a hierarchy of documents

In order to generate a hierarchy of documents, it is advisable to use
a directory per node in the hierarchy, and to factorise the common
parts of the documents using entities or parameter entities.  These
techniques are illustrated by the example found in
[the sources][www-example].


  [www-example]: https://github.com/michipili/bsdowl/blob/master/example/www
  [home-opensp]: http://www.jclark.com/sp/
