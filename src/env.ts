import { z } from 'zod'

export const envVars = z
  .object({
    NODE_ENV: z.string().default('development'),
    PORT: z.string().default('3000')
  })
  .parse(process.env)
