const {
  compilerOptions: { paths, outDir }
} = require('./tsconfig.json')

require('tsconfig-paths').register({
  baseUrl: outDir,
  paths: paths
})
