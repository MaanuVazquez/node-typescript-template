# Base NODE image
FROM node:16-bullseye-slim as base
# Enable yarn
RUN corepack enable

# Install all dependencies
FROM base as deps

RUN mkdir /app
WORKDIR /app

ADD package.json yarn.lock ./
RUN corepack enable
RUN yarn install --production=false

# Install production dependencies
FROM base as production-deps

RUN mkdir /app
WORKDIR /app
ENV NODE_ENV=production
ADD package.json yarn.lock ./
RUN yarn install

# Build the app
FROM base as build

ENV NODE_ENV=production

RUN mkdir /app
WORKDIR /app

COPY --from=deps /app/node_modules /app/node_modules

ADD . .
RUN yarn build

# Finally, build the production image with minimal footprint
FROM base

ENV NODE_ENV=production

RUN mkdir /app
WORKDIR /app

COPY --from=production-deps /app/node_modules /app/node_modules

COPY --from=build /app/dist /app/dist
ADD . .

CMD ["yarn", "start"]