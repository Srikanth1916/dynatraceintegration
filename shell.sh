
echo "fetch content"
git fetch --unshallow --tags		
echo "tagging content"
git tag -l 
echo "first"
echo github.ref
echo "second"
echo ${{ github.ref }}

#if grep ${{ github.ref }} file
#then
#   echo "Match found and good to proceed with the next steps"
#else
#   echo "Match does not found"
#exit 1 
#fi

