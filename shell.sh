git fetch --unshallow --tags
git tag -l > file1
echo ${{ github.ref }} > file2 
cat file2 | awk -F '/' '{print $3}' > file3
C=`cat file3`

if grep $C file1
then
  echo "Latest tag is found and good to proceed with the next steps"
else
  echo "Latest tag is not found"
exit 1
fi
