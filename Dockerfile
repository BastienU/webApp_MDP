# frontend/Dockerfile

FROM dart:stable AS builder

# Installe Flutter manuellement
RUN apt-get update && apt-get install -y curl unzip git xz-utils zip libglu1-mesa openjdk-17-jdk

RUN git clone https://github.com/flutter/flutter.git -b stable /flutter
ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Run flutter doctor once
RUN flutter doctor


WORKDIR /app
COPY . .

# Compilation en mode web
RUN flutter build web

# Étape de déploiement avec Nginx
FROM nginx:alpine
COPY --from=builder /app/build/web /usr/share/nginx/html

EXPOSE 80