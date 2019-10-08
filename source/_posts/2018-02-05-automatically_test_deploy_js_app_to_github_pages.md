---
layout: post
title:  "6个简单的步骤来自动测试和部署你的JavaScript程序到GitHub页面"
date:   2018-02-05 11:11:11
categories: ci
---

![img](https://cdn-images-1.medium.com/max/1600/1*7NIjF1hy4crepll1cnaxzA.png)

Workflow as per example below

Wouldn’t it be amazing if your new React app tested and deployed itself automatically? It’s very simple thanks to GitHub and Travis CI (CI stands for Continuous Integration).

This guide is for you if you:

- **Know** how to create a JavaScript app. This example focuses on a simple React app, but all apps that follow the typical test and build jobs can be adapted.
- **Know** what unit tests are.
- **Reasonably familiar** with Git and/or GitHub.
- **Reasonably familiar** with the command line.
- **Don’t know** how to set up automatic tests and deployment.
- **Need** free hosting to show off your latest JavaScript project.

The guide will show how to create a simple React application, push it to GitHub, link it to Travis CI and then to GitHub Pages. The tutorial will not focus on what React is.

------

### Step 1. Create a JavaScript app. Add tests.

For the purposes of this tutorial I will be using [create-react-app](https://github.com/facebookincubator/create-react-app), an ingenious tool for quick and tool-less creation of React apps. Apps made using the tool already have a sample unit test written.

- Make sure you have [NodeJS and NPM](https://nodejs.org/en/) installed. Run quick test commands `node -v` and `npm -v` to double-check.
- Run`npm install -g create-react-app` to install the create-react-app utility globally on your computer
- To create a new app, `create-react-app test-app` . This command takes some time. Once complete, your app will be located in the /test-app directory.
- Make sure the app runs properly. Navigate to the project directory and run `npm run start` or `npm start` to start the development server. Once everything works, cancel the task by pressing ctrl+c.
- Make sure that `npm run test` runs successfully. It should have a single test suite setup with a single test in it.
- Make sure the `npm run build` command works. It should create a deployment-ready build in the /build folder.

### Step 2. Create a GitHub repository, push your app.

Create an empty repository in GitHub without any files it. Make sure you have an SSH key added for your machine, then add your project files to a new git repo, then push it:

```
git init
git add .
git commit -m "first commit"
git remote add origin (URL OF YOUR REPOSITORY)
git push -u origin master
```

Refresh your repository page to make sure your app is now on GitHub.

### Step 3. Generate a GitHub token.

On GitHub, go to your account settings -> [Personal Access Tokens](https://github.com/settings/tokens).

Generate a new token. The token has to have the ‘repo’ scope selected in order to be able to access your repositories. Save the token in a save place and do not include in any public repositories in plain text. The token will be used in the next section.

**Note**: the token should not be shared with anyone, it essentially gives an app access to edit your repositories.

### Step 4. Link your project to Travis CI, add the .travis.yml file.

If you haven’t already, [create a Travis CI profile](https://travis-ci.org/) using your GitHub profile. Add your newly added GitHub project to Travis using the green switch.

Before we create the Travis config file, we will add the GitHub token you created above to the Travis project. Go to the project settings in Travis and add a new **Environmental Variable**. Call the variable **github_token**, and set the value to the token you got from GitHub. This will enable Travis to use your token without you having to publicly put in in your repository.

Add the following `.travis.yml` file to the root directory of your project:

```
language: node_js
node_js:
  - "stable"
cache:
  directories:
  - node_modules
script:
  - npm test
  - npm run build
deploy:
  provider: pages
  skip_cleanup: true
  github_token: $github_token
  local_dir: build
  on:
    branch: master
```

What each line means in the file:

```
language: node_js
```

Tells Travis to use NodeJS.

```
node_js:
  - "stable"
```

Tells Travis which version(s) of NodeJS to use. Feel free to add additional versions, such as `- "7"` or `- "6"` .

```
cache:
  directories:
  - node_modules
```

Tells Travis to cache the node_modules directory between builds instead of re-compiling the whole directory each time you commit.

```
script:
  - npm test
  - npm run build
```

**Important bit: **tells Travis which commands to run. Commands run in a succession, and if a command fails (i.e. exits with anything but 0), the build is marked as failed. Failed builds do not get deployed. Note that Travis knows to `npm install` already.

```
deploy:
  provider: pages
  skip_cleanup: true
  github_token: $github_token
  local_dir: build
  on:
    branch: master
```

The deployment structure. Detailed documentation about other deployment platforms available can be found [here](https://docs.travis-ci.com/user/deployment/).

`provider: pages` specifies we’re using GitHub Pages.

`skip_cleanup: true` tells Travis not to delete build files.

`github_token: $github_token` sets the GitHub token. We used an environment variable to avoid exposing our token to the public.

`local_dir: build` tells Travis to only take the files from the /build directory for deployment

`on: branch: master` tells Travis when to trigger deployment. We only want to deploy when we push to the master branch of the repository.

### Step 5. Set the homepage address in package.json

When you use GitHub Pages, your project is going to be hosted on a URL that looks like this:

```
https://USERNAME.github.io/PROJECT_NAME/
```

Following the above syntax, edit your `package.json` file to add a new entry with the URL of your project:

```
"homepage": "https://USERNAME.github.io/PROJECT_NAME/"
```

Setting the homepage informs the `npm run build` to add the right paths to the HTML file generated in the build directory.

### Step 6. Commit and push.

Add the new .travis.yml file to git, commit the repository and push it to GitHub. Travis will automatically start building, testing and deploying it.

```
git add .
git commit -m "Added the travis file and homepage"
git push origin master
```

Travis will queue your project and build it as soon as it can. You can follow the execution on your [home page](https://travis-ci.org/). Once tested and built — your project will update on GitHub in settings to show that it’s now hosted on GitHub Pages. A new branch called `gh-pages` is created on your repository. The page contains the output from the `npm run build` command.

### **All done!**

Check the URL created above and you should see your app there. This is the app I used for the guide, feel free to use for reference: [source code](https://github.com/slavabez/medium-test-app), [page hosted on GitHub Pages](https://slavabez.github.io/medium-test-app/) and the [Travis logs](https://travis-ci.org/slavabez/medium-test-app/).

------

### References:

Travis CI Docs: <https://docs.travis-ci.com/>

Travis CI Docs - GitHub Pages deployment: <https://docs.travis-ci.com/user/deployment/pages/>

Create-React-App Docs — Deployment: <https://github.com/facebookincubator/create-react-app/blob/master/packages/react-scripts/template/README.md#github-pages>