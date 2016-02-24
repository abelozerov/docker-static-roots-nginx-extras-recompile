#!/bin/sh

# Compiling static site if required
echo "`date`" "docker-static-roots-nginx-recompile: Starting container"

if [ -f "/temp/src/package.json" ]; then
	echo "`date`" "docker-static-roots-nginx-recompile: Static site source code found in /temp/src"

	cd /temp/src;
    echo "`date`" "docker-static-roots-nginx-recompile: Static site source code compilation started"
    npm install;
    roots compile;
    echo "`date`" "docker-static-roots-nginx-recompile: Static site source code compilation finished"

	# Copying compiled static site to Nginx html folder
	echo "`date`" "docker-static-roots-nginx-recompile: Copying compiled static site to Nginx html folder..."
	/bin/cp -af /temp/src/public/. /usr/share/nginx/html;
fi

# Starting Nginx
echo "`date`" "docker-static-roots-nginx-recompile: Starting nginx..."
nginx -g "daemon off;"