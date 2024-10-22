# Use latest stable channel SDK.
FROM dart:stable AS sdk

RUN dart pub global activate jaspr_cli

# Resolve app dependencies.
WORKDIR /app
COPY . .
COPY pubspec.* ./
COPY slang.* ./
RUN dart pub get
RUN dart run slang
RUN dart run build_runner build --delete-conflicting-outputs

# Copy app source code (except anything in .dockerignore) and AOT compile app.

# COPY . .
RUN dart pub global run jaspr_cli:jaspr build --verbose
# RUN dart compile exe bin/fakelab_records_bot.dart -o bin/fakelab_records_bot

# Build minimal serving image from AOT-compiled `/fakelab_records_bot`
# and the pre-built AOT-runtime in the `/runtime/` directory of the base image.
FROM scratch
COPY --from=sdk /runtime/ /
COPY --from=sdk /app/build/jaspr/ /app/

# Start server.
EXPOSE 8080
CMD ["./app"]
