## USE THIS TO CONVERT html zip of google doc to README FILE
# TO view the README FILE USE CHROMIUM EXTENSION
# https://chrome.google.com/webstore/detail/markdown-viewer/ckkdlimhmcjmikdlpkmbgfkaikojcbjk

htmlinput="DjangoDocumentationPart2.html"; mdoutput="DjangoDocumentation.md";  mdfinal="README.md"
perl -0777 -wpe's{(<p(?:(?!<p|</p>).)*</p>)}{ $1 =~ s/\n//gr }egmsx' $htmlinput  > tmp && mv tmp $htmlinput
pandoc -f html -t gfm --wrap=preserve -o $mdoutput $htmlinput
sed -i -r "s/^([0-9]+\.)( +#+ +)/\2\1/g" $mdoutput
sed -i -r "s/^ +//g" $mdoutput
sed -i -r 's/<!-- end list -->//g' $mdoutput
cp /home/web_dev/github_personl_token_for_gh_md_toc/token.txt .
split -b 300KB $mdoutput
rm -rf toc          
mkdir toc               
for f in x*;            
do              
cat $f | gh-md-toc - > toc/$f.toc
done;               
cat toc/*.toc > toc.md
sed -i -r 's/<span[^>]*>//g' $mdoutput
sed -i -r 's/<\/span>//g' $mdoutput
sed -i -r 's/<p[^>]*>//g' $mdoutput
sed -i -r 's/<\/p>/<br>/g' $mdoutput
awk '/<table>/{ORS=""} /<\/table>/{ORS=RS} 1' $mdoutput > tmp && mv tmp $mdoutput
sed -i '/^$/d;G' $mdoutput
sed -i -r 's/^./     * &/' $mdoutput
sed -i -r 's/^     \* (#[^#])/* \1/g' $mdoutput
sed -i -r 's/^     \* (##[^#])/ * \1/g' $mdoutput
sed -i -r 's/^     \* (###[^#])/     * \1/g' $mdoutput
sed -i -r 's/^     \* (####[^#])/       * \1/g' $mdoutput
sed -Ez -i 's/(\n)(       )(\* ####[^#][^\n]*\n\n)(     )(\* [^#])/\1\2\3\2  \5/g' $mdoutput
sed -Ez -i 's/(\n)(     )(\* ###[^#][^\n]*\n\n)(     )(\* [^#])/\1\2\3\2  \5/g' $mdoutput
sed -Ez -i 's/(\n)( )(\* ###[^#][^\n]*\n\n)(     )(\* [^#])/\1\2\3\2    \5/g' $mdoutput
sed -Ez -i 's/(\n)(\* ###[^#][^\n]*\n\n)(     )(\* [^#])/\1\2\3 \4/g' $mdoutput
awk 'BEGIN{count=0; prevNR=0; prevChar=""} match($0,/^(( +)(\*)( +))([^#].*)/,a){if(prevNR!=0 && NR == prevNR+2){print prevChar a[5]; prevNR = NR; } else{print; prevChar = a[1]; prevNR = NR} } !/^(( +)(\*)( +))([^#].*)/{ print } /^ +\* +#/{ prevChar = "" } ' $mdoutput > tmp && mv tmp $mdoutput
cat toc.md $mdoutput > $mdfinal
 
