FROM hexpm/elixir:1.13.3-erlang-24.0.2-ubuntu-bionic-20210325 AS builder

RUN apk add --update --no-cache \
    curl curl-dev make g++ postgresql-client bash openssh \
    git openssl ca-certificates gcc libgcc
    
ENV MIX_ENV=prod
ENV DATABASE_URL=${DATABASE_URL}
ENV SECRET_KEY_BASE=${SECRET_KEY_BASE}

RUN mix local.rebar --force && \
    mix local.hex --force

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix deps.get && \
  mix release --overwrite

FROM alpine:latest

RUN apk add --update --no-cache \
    curl curl-dev make g++ postgresql-client bash openssh git openssl libgcc

WORKDIR /app
COPY --from=builder /app/_build/prod/rel/rockelivery .

ENV PORT=4000
ENV APP_NAME=rockelivery
ENV MIX_ENV=prod

ENTRYPOINT ["/app/bin/rockelivery", "start"]