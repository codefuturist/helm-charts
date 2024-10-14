# Step 1: Checkout to the destination branch
git checkout gh-pages

# Step 2: Copy the files from the 'main' branch to 'gh-pages'
git checkout main -- index.yaml
git checkout main -- homarr-5.1.0.tgz
git checkout main -- application-5.1.0.tgz

# Step 3: Stage the copied files
git add index.yaml my-chart-0.1.0.tgz

# Step 4: Commit the changes
git commit -m "Move index.yaml and Helm chart from main to gh-pages"

# Step 5: Push the changes to the remote repository
git push origin gh-pages