###BASE###
FROM node:22-alpine as base

ENV PATH /node_modules/.bin:$PATH

ENV NODE_ENV=production

LABEL maintainer=01gr0nd5

COPY package.json package-lock.json tsconfig.json ./

RUN npm install -g npm@latest

RUN apk add tini --no-cache \
	&& npm config list \
	&& npm install \
#	&& npm outdated \
	&& npm cache clean --force

ENTRYPOINT ["tini", "--"]

###DEV###
FROM base as dev

ENV NODE_ENV=development

RUN npm install && npm cache clean --force

COPY . ./backend

WORKDIR /backend

CMD ["nest", "start", "--watch"] 

###PRE-PROD###
FROM dev as build

RUN npm run build

###TEST###
FROM dev as test

CMD ["npm", "run", "test"]

###AUDIT###
FROM test as audit

CMD ["npm", "run", "audit"]

###PROD###
FROM base as prod

COPY --chown=node:node --from=build ./backend/dist ./dist

HEALTHCHECK  --interval=30s --timeout=3s \
  CMD wget --no-verbose --tries=3 --spider http://127.0.0.1:3000/ || exit 1

CMD ["node", "./dist/main.js"]
