git checkout master

# Step 4: Commit the changes
# git commit -a -m "Move index.yaml and Helm chart from main to gh-pages"

# Step 5: Push the changes to the remote repository
# git push origin master



helm package homarr

helm package application

helm repo index . --url https://github.com/codefuturist/helm-charts/releases/download/

mv index.yaml /tmp/
mv *.tgz /tmp/

git commit -a -m "Move index.yaml and Helm chart from main to gh-pages"

# Step 1: Checkout to the destination branch
git checkout gh-pages

# Step 2: Copy the files from the 'main' branch to 'gh-pages'
git checkout master -- index.yaml

git checkout master -- homarr/
git checkout master -- nginx/
git checkout master -- homarr/

git checkout master -- application-5.1.0.tgz

# Step 3: Stage the copied files
# git add index.yaml application-5.1.0.tgz homarr-5.1.0.tgz


mv /tmp/index.yaml ./
mv /tmp/*.tgz ./

git add -A

git add -a
# Step 4: Commit the changes
git commit -m "Move index.yaml and Helm chart from main to gh-pages"

# Step 5: Push the changes to the remote repository
git push origin gh-pages