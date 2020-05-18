# DinoTasks

### Development

If you don't have a `PostgreSQL` installation on your machine, or your prefers Docker instead.

```bash
docker run -e POSTGRES_PASSWORD=postgres -d --name dino_tasks -v "$PWD/.database/dino_tasks":/var/lib/postgresql/data -p 5432:5432 postgres:12
```

Also remember if you have the port `5432` busy instead of `-p 5432:5432` use `-p my_port:5432` where my_port must be in the range of private ports, so 54320 could be enough.
be sure you also update the config at `config/dev.exs` and `config/test.exs` files.

```
config :dino_tasks, DinoTasks.Repo,
  ...
  port: 54323
```

```bash
docker run -e POSTGRES_PASSWORD=postgres -d --name dino_tasks -v "$PWD/.database/dino_tasks":/var/lib/postgresql/data -p 54323:5432 postgres:12
```

Then you must create the database to do that use `mix ecto.create` and then run `iex -S mix` to run the app and have an interactive shell.

To start your Phoenix server:

  * cd dino_tasks && mix deps.get && npm i --prefix assets && mix phx.gen.cert -o priv/ssl/dino_tasks
  * Start Phoenix endpoint with `mix phx.server` or `iex -S mix phx.server`.

Now you can visit [`localhost:4000`](https://localhost:4000) from your browser.

Remember to update the `mix.exs` file with your own configuration.

Accessing into [`dashboard`](https://localhost:4000/dashboard) requires credentials, check the `lib/dino_tasks_web/router.ex` file.

WARNING: only use the generated certificate for testing in a closed network
environment, such as running a development server on `localhost`.
For production, staging, or testing servers on the public internet, obtain a
proper certificate, for example from [Let's Encrypt](https://letsencrypt.org).

NOTE: when using Google Chrome, open chrome://flags/#allow-insecure-localhost
to enable the use of self-signed certificates on `localhost`.


### self-signed certs with [mkcert](https://github.com/FiloSottile/mkcert)

By default self-signed certs are invalid, but [mkcert](https://github.com/FiloSottile/mkcert) is the tool to make them valid, after you install it run.

```bash
mkcert -install
mkcert -key-file ./priv/ssl/dino_tasks_key.pem -cert-file ./priv/ssl/dino_tasks.pem dino_tasks "*.dino_tasks" localhost 127.0.0.1 ::1
```

### Production


### build a docker image (production mode).

```bash
docker build --build-arg DATABASE_URL=ecto://postgres:postgres@localhost/dino_tasks --build-arg SECRET_KEY_BASE=$(mix phx.gen.secret) --tag dino_tasks:$(grep 'version:' mix.exs | cut -d '"' -f2) .
```

### run the docker image.

```bash
docker run --publish 443:443 dino_tasks:$(grep 'version:' mix.exs | cut -d '"' -f2)
```