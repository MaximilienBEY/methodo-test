waitport() {
  while ! nc -z localhost $1 2>/dev/null ; do sleep 0.25 ; done
}

node server/index.js & echo $! > /tmp/pidfile
waitport 3000
printf "\n"