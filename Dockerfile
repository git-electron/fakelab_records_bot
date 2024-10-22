# Use latest stable channel SDK.
FROM dart:stable AS sdk

# Resolve app dependencies.
WORKDIR /app
COPY . .
COPY pubspec.* ./
COPY slang.* ./
COPY .env ./
RUN dart pub get
RUN dart pub global activate dotenv
RUN dart pub global run dotenv:new
RUN dart run slang
RUN dart run build_runner build --delete-conflicting-outputs

# Copy app source code (except anything in .dockerignore) and AOT compile app.

# COPY . .
RUN dart compile exe bin/fakelab_records_bot.dart -o bin/fakelab_records_bot
# RUN dart compile exe bin/fakelab_records_bot.dart -o bin/fakelab_records_bot

# Build minimal serving image from AOT-compiled `/fakelab_records_bot`
# and the pre-built AOT-runtime in the `/runtime/` directory of the base image.
FROM scratch
COPY --from=sdk /runtime/ /
COPY --from=sdk /app/bin/fakelab_records_bot /app/bin/
COPY --from=sdk /app/.env /app/bin/.env

# Start server.
EXPOSE 8080
CMD ["/app/bin/fakelab_records_bot"]
