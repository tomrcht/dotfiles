function push-all
git remote | xargs -L1 git push --all
end
