git fetch --unshallow --tags
git tag -l > file1
echo ${{ github.ref }} | awk -F '/' '{print $3}' > file2
C=`cat file2`

if grep $C file1
then
  echo "Latest tag is found and good to proceed with the next steps"
else
  echo "Latest tag is not found"
exit 1
fi
