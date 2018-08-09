@echo ON
setlocal
rem SET OPENSSL_PATH=c:\tools\openssl\bin\
rem SET CERT_OUTPUT_PATH=c:\keys\
rem SET OPENSSL_CONF=%OPENSSL_PATH%openssl.cnf
C:\OpenSSL-Win32\bin\openssl genrsa -des3 -out c:\cosmos.key 2048
C:\OpenSSL-Win32\bin\openssl req -new -x509 -nodes -sha1 -days 1095 -key c:\cosmos.key > c:\cosmos.crt
rem C:\OpenSSL-Win32\bin\openssl req -new -newkey rsa:2048 -days 1095 -nodes -x509 -keyout c:\cosmos.key -out c:\cosmos.pem
endlocal
pause