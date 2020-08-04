########################################
# Build layer
########################################
FROM node:14.3.0-stretch-slim as build

WORKDIR /svelte

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

# EXPOSE 1234
# CMD ["npm", "run", "start"]

########################################
# Run layer
########################################
FROM node:14.3.0-stretch-slim as app

WORKDIR /app

COPY --from=build /svelte/dist /svelte/package.json /svelte/package-lock.json ./
RUN npm install --production

EXPOSE 1234
CMD ["./node_modules/serve/bin/serve.js", "-l", "1234"]
