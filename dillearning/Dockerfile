# docker para nuestro build en web del frontend
FROM ghcr.io/cirruslabs/flutter:latest as builder

WORKDIR /app

COPY . .

RUN flutter pub get
RUN flutter build web --dart-define=APP_ENV=docker

FROM nginx:alpine
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY flutter-web.conf /etc/nginx/conf.d/

COPY --from=builder /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
