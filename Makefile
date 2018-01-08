build:
	@cp -R src public

serve:
	@cd public && nohup python -m SimpleHTTPServer 9898 > /dev/null & 2>&1 && echo "Serving on localhost:9898"

stop:
	@ps aux | grep "python -m SimpleHTTPServer" | tail -n1 | awk '{print $$2}' | xargs kill
