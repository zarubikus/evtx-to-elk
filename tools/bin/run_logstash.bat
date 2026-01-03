@echo off

SET LS_JAVA_HOME=
\tools\logstash\bin\logstash.bat -f \tools\configs\logstash_hayabusa.conf --log.level error 

pause