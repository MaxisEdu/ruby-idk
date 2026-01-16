FROM jruby:9.4-jdk

ENV APP_ROOT=/app
WORKDIR $APP_ROOT

# (Opcional, mas ajuda) dependências do sistema
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends build-essential nodejs && \
    rm -rf /var/lib/apt/lists/*

# Copia Gemfile primeiro para aproveitar cache das gems
COPY Gemfile Gemfile.lock* ./

# Instala as gems usando JRuby
RUN jruby -S bundle install

# Copia o resto do projeto
COPY . .

EXPOSE 3000

# Sobe o servidor Rails com JRuby
CMD ["jruby", "-S", "bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
