import { envVars } from '~/env'

function main() {
  console.log(envVars.NODE_ENV, envVars.PORT)
}

main()
