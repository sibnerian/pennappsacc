# Running the project

In order to run the project, you should need to install the dependencies, then use Gulp.
```
npm install
gulp --require coffee-script/register
```

This will: 

1. Build all coffeescript/LessCSS files, and transfer them along with all other files into `./build` 
2. Use Nodemon to restart the project whenever files change
3. Trigger a Nodemon restart whenever a file changes, including app.js