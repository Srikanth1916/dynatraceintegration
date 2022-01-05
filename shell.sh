git fetch --unshallow --tags		
git tag -l > file
if grep github.ref file
then
   echo "Match found and good to proceed with the next steps"
else
   echo "Match does not found"
exit 1 
fi
