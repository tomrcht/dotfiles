function aes
	openssl enc -aes-256-cbc -k $argv -P -md sha1
end
