FROM node:20-alpine as base

ENV PATH /node_modules/.bin:$PATH

ENV NODE_ENV=production

LABEL maintainer=krusts31

WORKDIR /frontend

RUN npm install -g npm@10.5.2

COPY --chown=node:node package.json\
	tsconfig.app.json\
	tsconfig.json\
	tsconfig.node.json\
	tsconfig.vitest.json\
	vite.config.ts\
	vitest.config.ts\
	index.html\
	./

COPY --chown=node:node ./public/  ./public
COPY --chown=node:node ./cypress/  ./cypress

RUN apk add tini --no-cache\
	&& npm config list\
    && npm install

ENTRYPOINT ["tini", "--"]

###DEV###
FROM base as dev

ENV NODE_ENV=development

RUN npm install

COPY --chown=node:node ./src ./src

COPY --chown=node:node ./.env ./

CMD ["npm", "run", "dev"] 

###PRE-PROD###
FROM dev as build

COPY --chown=node:node ./.env.production ./

RUN npm run build

###TEST###
FROM dev as test

CMD ["npm", "run", "test-ci"]

###AUDIT###
FROM test as audit

CMD ["npm", "run", "audit"]

###PROD###
FROM nginx:alpine as prod

COPY --chown=nginx:nginx --from=build ./frontend/dist ./build

COPY default.conf /etc/nginx/conf.d/

HEALTHCHECK  --interval=30s --timeout=3s \
  CMD wget --no-verbose --tries=3 --spider http://127.0.0.1:9005/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
