function 80columns
	cat * | awk '{print length, $0}' | sort -nr | less
end
