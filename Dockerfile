FROM elixir:alpine

RUN mkdir /app
COPY . /app
WORKDIR /app

# In a production environment these values would be set using something like docker secrets
ENV API_KEY=
ENV SECRET_KEY_BASE=

ENV APP_PORT=4000
ENV APP_HOSTNAME=localhost
ENV MIX_ENV=prod

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get

EXPOSE 4000

RUN mix deps.compile
RUN mix release

CMD ["_build/prod/rel/weather/bin/weather", "start"]
