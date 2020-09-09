FROM node:12.18.3-alpine as base

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ENV HUSKY_SKIP_INSTALL=true

COPY package.json package-lock.json ./
RUN npm ci

COPY . .
FROM base as tests

FROM base as app
RUN npm run build
CMD ["npm", "start"]
