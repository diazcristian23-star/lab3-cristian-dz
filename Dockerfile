FROM node:24
WORKDIR /app
RUN corepack enable

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
RUN pnpm install

COPY . . 
RUN pnpm build

EXPOSE 3000
CMD ["pnpm", "run", "start:prod"]