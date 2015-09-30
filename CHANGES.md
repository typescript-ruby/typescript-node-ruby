## v1.6.2 2015-09-30 12:14:00+0300
* Updated typescript-src gem version to v1.6.2

## v1.4.1 2015-07-06 22:36:25+0300

* Added stdout to output when Typescript compilation error occurs

## v1.1.1 2015-04-19 15:40:00+0900

* Use capture3 instead of popen3 to handle tsc I/O.

## v1.1.0 2014-08-09 10:06:10+0900

* compile_file now takes tsc(1) options (#3):
  `TypeScript::Node.compile_file('file', '--target', 'ES5')`

## v1.0.0 2014-08-09 09:06:11+0900

* Depends on newer versions of typescript-src
* No feature change from previous versions
