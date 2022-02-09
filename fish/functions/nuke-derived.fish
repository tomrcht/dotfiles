function nuke-derived
	du -hs ~/Library/Developer/Xcode/DerivedData/
	rm -rf ~/Library/Developer/Xcode/DerivedData/
end
