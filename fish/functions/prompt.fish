###
# Get git branch
###
function _git_branch_name
	echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

###
# Check repo status
###
function _git_is_dirty
	echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt
	set -l last_status $status

	set -l cyan (set_color cyan)
	set -l yellow (set_color yellow)
	set -l red (set_color red)
	set -l blue (set_color blue)
	set -l green (set_color green)
	set -l normal (set_color normal)

	set -l cwd $blue(pwd | sed "s:^$HOME:~:")
  # echo -e ''

	if test $last_status != 0
		echo -n -s $red $last_status $normal ' · '
	end

	###
	# Print current path
	###
	echo -n -s $cwd $normal

	###
	# Git branch and status (clean / dirty)
	###
	if [ (_git_branch_name) ]
		set -l git_branch (_git_branch_name)

	if [ (_git_is_dirty) ]
		set git_info '(' $yellow $git_branch "±" $normal ')'
	else
		set git_info '(' $green $git_branch $normal ')'
	end
	echo -n -s ' · ' $git_info $normal
end

	set -l prompt_color $normal
	if test $last_status != 0
		set prompt_color $red
	end
	echo -e ''
	echo -e -n -s $prompt_color '⟩ ' $normal
end
