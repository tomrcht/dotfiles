function repoc
	blih -u tom.rochat@epitech.eu repository create $argv
blih -u tom.rochat@epitech.eu repository setacl $argv ramassage-tek r
git clone git@git.epitech.eu:/tom.rochat@epitech.eu/$argv
end
